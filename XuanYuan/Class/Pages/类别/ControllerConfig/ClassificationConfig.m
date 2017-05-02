//
//  ClassificationConfig.m
//  XuanYuan
//
//  Created by King on 2017/5/1.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "ClassificationConfig.h"


@interface ClassificationConfig()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>

@end

@implementation ClassificationConfig

-(UIView *)view
{
    if (_view == nil) {
        _view = [[UIView alloc]initWithFrame:self.controller.view.bounds];
    }
    return _view;
}

- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init];
    if (self) {
        
        _controller = controller;
        
    }
    return self;
}

-(void)drawView
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configData) name:kReloadClassification_Noti object:nil];
    [self.view addSubview:self.tableView];
    [self configDataNoRefresh];
    [self.tableView reloadDataWithDirectionType:ZPReloadAnimationDirectionBottom AnimationTimeNum:0.5 interval:0.05];
    
}

-(void)removeSubView
{
    CATransform3D transform = CATransform3DIdentity;
    self.view.layer.opacity = 1;
    [UIView animateWithDuration:0.4f animations:^{
        self.view.layer.transform = CATransform3DScale(transform, 0.1, 0.1, 1);;
        self.view.layer.opacity = 0;
    } completion:^(BOOL finished) {
       
        [self.view removeFromSuperview];

    }];
}



-(void)reloadMyTableView
{
    [self.tableView cyl_reloadData];
}

-(void)configData
{
    [self configDataNoRefresh];
    [self reloadMyTableView];
}

-(void)configDataNoRefresh
{
    
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:[ClassificationModel getMainModelArray]];

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
        
        [self reloadMyTableView];
        [_tableView.mj_header endRefreshing];
        
    });
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
    
    if (self.controller.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self.controller registerForPreviewingWithDelegate:(id)self sourceView:cell];
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
    [self.controller.navigationController.view.layer addAnimation:[HTTools createTransitionAnimationWithType:@"moveIn" direction:@"fromTop" time:0.4] forKey:nil];
    [self.controller.navigationController pushViewController:vc animated:NO];
    [self reloadMyTableView];
}


/**
 删除
 */
-(void)deleteAccount:(ClassificationModel *)model
{
    [self.dataArray removeObject:model];
    [self reloadMyTableView];
    
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
    vc.isPeek = NO;
    [self.controller presentViewController:vc animated:NO completion:^{}];
}



- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    ClassificationCell *cell;
    if (ht_IOS9_OR_LATER) {
        cell = (ClassificationCell *)previewingContext.sourceView;
    }else
    {
        cell = [self.tableView cellForRowAtIndexPath:[self.tableView indexPathForRowAtPoint:location]];
    }
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    DetailCopyViewController *detailVC = [sb instantiateViewControllerWithIdentifier:@"DetailCopyViewController"];
    detailVC.isPeek = YES;
    detailVC.model = cell.model;
    return detailVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    DetailCopyViewController *detailVC = (DetailCopyViewController *)viewControllerToCommit;
    detailVC.isPeek = NO;
    [self.controller presentViewController:detailVC animated:YES completion:nil];
}




#pragma mark - PlaceHolderDelegate
- (UIView *)makePlaceHolderView
{
    UIImage *zanwei = [UIImage imageNamed:@"zanwei_Icon"];
    HTPlaceHolderView *view = [[HTPlaceHolderView alloc]init];
    view.bgImage = zanwei;
    return view;
}
- (BOOL)enableScrollWhenPlaceHolderViewShowing
{
    return YES;
}

@end
