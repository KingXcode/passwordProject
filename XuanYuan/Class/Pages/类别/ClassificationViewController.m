//
//  ClassificationViewController.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "ClassificationViewController.h"
#import "HTAddItemsViewController.h"
#import "HTDataBaseManager.h"
#import "ClassificationModel.h"
#import "ClassificationCell.h"
#import "HTEditItemsViewController.h"
#import "DetailCopyViewController.h"
#import "Setting_interface_ViewController.h"
#import "HTNavigationController.h"


@interface ClassificationViewController ()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate,RZTransitionInteractionControllerDelegate>


@property (nonatomic, strong) id<RZTransitionInteractionController> presentInteractionController;



@property (nonatomic,weak)UIButton *titleButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;

@property (nonatomic,strong)NSMutableArray<ClassificationModel *> *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation ClassificationViewController
- (IBAction)settingItem:(id)sender {
    Setting_interface_ViewController *vc = instantiateStoryboardControllerWithIdentifier(@"SettingHTNavigationController");
    
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (IBAction)addItem:(UIBarButtonItem *)sender {
    HTAddItemsViewController *vc = [[HTAddItemsViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view.layer addAnimation:[HTTools createTransitionAnimationWithType:@"moveIn" direction:@"fromTop" time:0.4] forKey:nil];
    [self.navigationController pushViewController:vc animated:NO];
}

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, IPHONE_WIDTH, self.view.bounds.size.height);
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = MainTableViewBackgroundColor;
        [_tableView registerNib:[UINib nibWithNibName:@"ClassificationCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        

        HTDIYRefreshHeader *header = [HTDIYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _tableView.mj_header = header;
        
        _tableView.tableFooterView = [UIView new];
        

    }
    return _tableView;
}

-(void)refresh
{
    [self configDataNoRefresh];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
        
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitleButton];
    
    self.title = @"账号";
    
    
    [self annimation];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configData) name:kReloadClassification_Noti object:nil];

    [self.view addSubview:self.tableView];
    
    [self configDataNoRefresh];
    
    [self.tableView reloadDataWithDirectionType:ZPReloadAnimationDirectionBottom AnimationTimeNum:0.5 interval:0.05];
    

}


-(void)setTitleButton
{
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"下标"] forState:UIControlStateNormal];
    [titleButton setBackgroundImage:[HTTools ht_createImageWithColor:RGBA(34, 34, 34, 0.3)] forState:UIControlStateHighlighted];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [titleButton addTarget:self action:@selector(clickTopButton) forControlEvents:UIControlEventTouchUpInside];
    
    titleButton.layer.cornerRadius = 4;
    titleButton.layer.masksToBounds = YES;
    
    
    [titleButton sizeToFit];
    self.navigationItem.titleView = titleButton;
    self.titleButton = titleButton;
}

-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    [self.titleButton setTitle:title forState:UIControlStateNormal];
    [self.titleButton sizeToFit];
}




-(void)configData
{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:[ClassificationModel getMainModelArray]];
    [self.tableView reloadData];
}

-(void)configDataNoRefresh
{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:[ClassificationModel getMainModelArray]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setInteractionController];

}


//MARK: - TableView数据源方法-代理方法

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    return;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationModel *model = self.dataArray[indexPath.row];
    
    return model.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationModel *model = self.dataArray[indexPath.row];
    
    ClassificationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.model = model;
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
    }
    
    __weak typeof(self) __self = self;
    [cell setLongPressCell:^(ClassificationModel *m, UILongPressGestureRecognizer *g) {
        
        [__self presentDetailCopyControllerWithModel:m andGestureRecognizer:g];
        
    }];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClassificationModel *model = self.dataArray[indexPath.row];
    model.selectState = !model.selectState;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationModel *model = self.dataArray[indexPath.row];
    if (model.selectState == YES) {
        return NO;
    }else
    {
        return YES;

    }
    
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationModel *model = self.dataArray[indexPath.row];
    __weak typeof(self) __self = self;
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        [__self deleteAccount:model];

        
    }];

    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [__self editAccount:model];
        
    }];
    
    if (model.isCollect) {
        
        UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            model.isCollect = NO;
            [__self collectAccount:model];
            [__self configData];
        }];
        action2.backgroundColor = MainCollectColor;

        return @[action,action2,action3];

    }else
    {
        UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            model.isCollect = YES;
            [__self collectAccount:model];
            [__self configData];
        }];
        action1.backgroundColor = MainCollectColor;
        
        return @[action,action1,action3];
    }
}

/**
 编辑
 */
-(void)editAccount:(ClassificationModel *)model
{
    HTEditItemsViewController *vc = [[HTEditItemsViewController alloc]init];
    vc.MainModel = model;
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.view.layer addAnimation:[HTTools createTransitionAnimationWithType:@"moveIn" direction:@"fromTop" time:0.4] forKey:nil];
    [self.navigationController pushViewController:vc animated:NO];
    [self.tableView reloadData];
}


/**
 删除
 */
-(void)deleteAccount:(ClassificationModel *)model
{
    [self.dataArray removeObject:model];
    [self.tableView reloadData];
    
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    [manager deleteAccountListByModel:model];
    
    if (model.isCollect) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];
    }
}


/**
 收藏  取消收藏
 */
-(void)collectAccount:(ClassificationModel *)model
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    [manager updataAccountListByModel:model];
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];
}


-(void)presentDetailCopyControllerWithModel:(ClassificationModel *)model
                       andGestureRecognizer:(UILongPressGestureRecognizer *)gesture
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailCopyViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DetailCopyViewController"];
    vc.model = model;
    [self presentViewController:vc animated:NO completion:^{}];
}

/**
 点击顶部按钮
 */
-(void)clickTopButton
{
    
    [self presentViewController:[self nextCollectViewController] animated:YES completion:nil];
    
    
}




- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    ClassificationCell *cell = (ClassificationCell *)previewingContext.sourceView;
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailCopyViewController *detailVC = [sb instantiateViewControllerWithIdentifier:@"DetailCopyViewController"];
    detailVC.isPeek = YES;
    detailVC.model = cell.model;
    return detailVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    DetailCopyViewController *detailVC = (DetailCopyViewController *)viewControllerToCommit;
    [self presentViewController:detailVC animated:YES completion:nil];
}




-(void)annimation
{
    self.presentInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [self.presentInteractionController setNextViewControllerDelegate:self];
    [self.presentInteractionController attachViewController:self withAction:RZTransitionAction_Present];
    
    [[RZTransitionsManager shared] setAnimationController:[[RZCirclePushAnimationController alloc] init]
                                       fromViewController:[self class]
                                                forAction:RZTransitionAction_PresentDismiss];
}


-(void)setInteractionController
{
    [[RZTransitionsManager shared] setInteractionController:self.presentInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Present];
}



- (UIViewController *)nextCollectViewController
{
    HTNavigationController *nav = instantiateStoryboardControllerWithIdentifier(@"CollecHTNavigationController");
    [nav setTransitioningDelegate:[RZTransitionsManager shared]];
    
    RZVerticalSwipeInteractionController *dismissInteractionController = [[RZVerticalSwipeInteractionController alloc] init];
    [dismissInteractionController attachViewController:nav withAction:RZTransitionAction_Dismiss];
    
    [[RZTransitionsManager shared] setInteractionController:dismissInteractionController
                                         fromViewController:[self class]
                                           toViewController:nil
                                                  forAction:RZTransitionAction_Dismiss];
    
    return nav;
}

#pragma mark - RZTransitionInteractorDelegate
- (UIViewController *)nextViewControllerForInteractor:(id<RZTransitionInteractionController>)interactor
{
    return [self nextCollectViewController];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
