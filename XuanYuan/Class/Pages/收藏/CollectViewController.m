//
//  CollectViewController.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "CollectViewController.h"
#import "ClassificationModel.h"
#import "ClassificationCell.h"
#import "HTDataBaseManager.h"
#import "HTEditItemsViewController.h"
#import "DetailCopyViewController.h"
#import "HTNotesViewController.h"
#import "HTNavigationController.h"

@interface CollectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak)UIButton *titleButton;


@property (nonatomic,strong)NSMutableArray<ClassificationModel *> *dataArray;
@property (nonatomic,strong)UITableView *tableView;

@end

@implementation CollectViewController


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
        
        [self reloadMyTableView];
        [_tableView.mj_header endRefreshing];
        
    });
}

-(void)reloadMyTableView
{
    [self.tableView cyl_reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleButton];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configData) name:kReloadCollect_Noti object:nil];

    self.title = @"收藏";
    
    [self.view addSubview:self.tableView];
    
    [self configData];

}

-(void)setTitleButton
{
    UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
- (IBAction)goback:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/**
 点击顶部按钮
 */
-(void)clickTopButton
{
   
}

-(void)configData
{
    [self configDataNoRefresh];
    [self reloadMyTableView];
}

-(void)configDataNoRefresh
{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:[ClassificationModel getCollectModelArray]];
}




//MARK: - TableView数据源方法-代理方法



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
    
    __weak typeof(self) __self = self;
    [cell setLongPressCell:^(ClassificationModel *m, UILongPressGestureRecognizer *g) {
        
        [__self presentDetailCopyControllerWithModel:m andGestureRecognizer:g];
        
    }];
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ClassificationModel *model = self.dataArray[indexPath.row];
    
    model.selectState = !model.selectState;
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        model.isCollect = NO;
        [__self collectAccount:model];
        [__self configData];
    }];
    action2.backgroundColor = MainCollectColor;
    
    
    
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [__self editAccount:model];
        
    }];
    

    return @[action2,action3];
    
}

/**
 编辑
 */
-(void)editAccount:(ClassificationModel *)model
{
    
    if (model.iconType == 1000)
    {
        HTNotesViewController *vc = [[HTNotesViewController alloc]init];
        vc.model = model;
        HTNavigationController *nav = [[HTNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    else
    {
        HTEditItemsViewController *vc = [[HTEditItemsViewController alloc]init];
        vc.MainModel = model;
        HTNavigationController *nav = [[HTNavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    [self reloadMyTableView];
}



/**
 收藏  取消收藏
 */
-(void)collectAccount:(ClassificationModel *)model
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    [manager updataAccountListByModel:model];
    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadClassification_Noti object:nil];
}

-(void)presentDetailCopyControllerWithModel:(ClassificationModel *)model
                       andGestureRecognizer:(UILongPressGestureRecognizer *)gesture
{
    UIImage *image = [HTTools ht_captureScreen];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailCopyViewController *vc = [sb instantiateViewControllerWithIdentifier:@"DetailCopyViewController"];
    vc.model = model;
    [self presentViewController:vc animated:NO completion:^{
        vc.backImageView.image = image;
    }];
}

- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    ClassificationCell *cell;
    if (ht_IOS9_OR_LATER) {
        cell = (ClassificationCell *)previewingContext.sourceView;
    }else
    {
        cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:location]];
    }    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailCopyViewController *detailVC = [sb instantiateViewControllerWithIdentifier:@"DetailCopyViewController"];
    detailVC.isPeek = YES;
    detailVC.model = cell.model;
    detailVC.preferredContentSize = CGSizeMake(IPHONE_WIDTH*0.9, IPHONE_HEIGHT*0.9);

    return detailVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    DetailCopyViewController *detailVC = (DetailCopyViewController *)viewControllerToCommit;
    [self presentViewController:detailVC animated:YES completion:nil];
}



#pragma mark - PlaceHolderDelegate
- (UIView *)makePlaceHolderView
{
    UIImage *zanwei = [UIImage imageNamed:@"zanwei_Icon"];
    HTPlaceHolderView *view = [[HTPlaceHolderView alloc]init];
    view.bgImage = zanwei;
    return view;}

- (BOOL)enableScrollWhenPlaceHolderViewShowing
{
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
