//
//  ClassificationConfig.m
//  XuanYuan
//
//  Created by King on 2017/5/1.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "ClassificationConfig.h"

#import "XuanYuanGloabal.h"
#import "HTNotesViewController.h"

#define HeaderHeight 40
#define FooterHeight 4


@interface ClassificationConfig()<UITableViewDelegate,UITableViewDataSource,UIViewControllerPreviewingDelegate>

@property (nonatomic,readonly,copy)NSArray *mainArray;//实例对象始终是空的   我这里只是用到了点语法的get方法
@property (nonatomic,strong)NSMutableArray<ClassificationModel *> *accountArray;
@property (nonatomic,strong)NSMutableArray<ClassificationModel *> *notesArray;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,weak)UIViewController *controller;

@property (nonatomic,assign) BOOL isHiddenNotes;

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
        _isHiddenNotes = NO;
        
    }
    return self;
}

-(void)drawView
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(configData) name:kReloadClassification_Noti object:nil];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.mas_equalTo(0);
        
    }];
    
    [self configDataNoRefresh];
    [self.tableView reloadDataWithDirectionType:ZPReloadAnimationDirectionRight AnimationTimeNum:0.5 interval:0.05];
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
    
    [_accountArray removeAllObjects];
    [_accountArray addObjectsFromArray:[ClassificationModel getMainModelArray]];
    
    [_notesArray removeAllObjects];
    [_notesArray addObjectsFromArray:[ClassificationModel getNotesModelArray]];

}
-(BOOL)isHiddenNotes
{
    if (self.notesArray.count<=0) {
        _isHiddenNotes = NO;
    }
    return _isHiddenNotes;
}
-(NSArray *)mainArray
{
    
    if (self.isHiddenNotes) {
        
        return @[@[],self.accountArray];

    }else
    {
        return @[self.notesArray,self.accountArray];
    }
}

-(NSMutableArray<ClassificationModel *> *)notesArray
{
    if (_notesArray == nil) {
        _notesArray = [NSMutableArray array];
    }
    return _notesArray;
}

-(NSMutableArray<ClassificationModel *> *)accountArray
{
    if (_accountArray == nil) {
        _accountArray = [NSMutableArray array];
    }
    return _accountArray;
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HeaderHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FooterHeight;
}
//无效
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return @"备忘录";
        
    }else if (section == 1)
    {
        return @"账号";
    }
    return @"";
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //这里说实话  我只想乱写  应该是要单独封装一个view的
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]init];
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = MainTextColor;
    [view addSubview:imageView];
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.right.equalTo(view).mas_offset(-8);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view);
        make.left.equalTo(view).mas_offset(8);
        make.width.height.mas_equalTo(HeaderHeight-8);
    }];
    
    

    if (section == 0) {//add_笔记   备忘录
        [view addClickBlock:^(id obj) {
            self.isHiddenNotes = !self.isHiddenNotes;
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                     withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        label.text = @"备忘录";
        imageView.image = [UIImage imageNamed:@"add_笔记"];

        return view;
        
    }else if (section == 1)//add_账号   账号
    {
        label.text = @"账号";
        imageView.image = [UIImage imageNamed:@"add_账号"];

        return view;
    }
    return [UIView new];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mainArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = self.mainArray[section];
    return arr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<ClassificationModel *> *arr = self.mainArray[indexPath.section];
    ClassificationModel *model = arr[indexPath.row];
    return model.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<ClassificationModel *> *arr = self.mainArray[indexPath.section];
    ClassificationModel *model = arr[indexPath.row];
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
    NSArray<ClassificationModel *> *arr = self.mainArray[indexPath.section];
    ClassificationModel *model = arr[indexPath.row];
    model.selectState = !model.selectState;

    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
             withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<ClassificationModel *> *arr = self.mainArray[indexPath.section];
    ClassificationModel *model = arr[indexPath.row];
    if (model.selectState == YES) {
        return NO;
    }else
    {
        return YES;
    }
    
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray<ClassificationModel *> *arr = self.mainArray[indexPath.section];

    ClassificationModel *model = arr[indexPath.row];
    __weak typeof(self) __self = self;
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [__self deleteAccount:model AtIndexPath:indexPath];
        
        
    }];
    
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"编辑" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [__self editAccount:model AtIndexPath:indexPath];
        
    }];
    
    if (model.isCollect) {
        
        UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"取消收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            model.isCollect = NO;
            [__self collectAccount:model AtIndexPath:indexPath];
            [__self configData];
        }];
        action2.backgroundColor = MainCollectColor;
        
        return @[action,action2,action3];
        
    }else
    {
        UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
            model.isCollect = YES;
            [__self collectAccount:model AtIndexPath:indexPath];
            [__self configData];
        }];
        action1.backgroundColor = MainCollectColor;
        
        return @[action,action1,action3];
    }
}

/**
 编辑
 */
-(void)editAccount:(ClassificationModel *)model AtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        HTNotesViewController *vc = [[HTNotesViewController alloc]init];
        vc.model = model;
        HTNavigationController *nav = [[HTNavigationController alloc]initWithRootViewController:vc];
        [self.controller presentViewController:nav animated:YES completion:nil];
    }
    else if (indexPath.section == 1)
    {
        HTEditItemsViewController *vc = [[HTEditItemsViewController alloc]init];
        vc.MainModel = model;
        HTNavigationController *nav = [[HTNavigationController alloc]initWithRootViewController:vc];
        [self.controller presentViewController:nav animated:YES completion:nil];
    }


}


/**
 删除
 */
-(void)deleteAccount:(ClassificationModel *)model AtIndexPath:(NSIndexPath *)indexPath
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];

    if (indexPath.section == 0) {
        
        [self.notesArray removeObject:model];
        [self reloadMyTableView];
        [manager deleteNotesListByModel:model];
        if (model.isCollect) {
            [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];
        }
        
    }
    else if (indexPath.section == 1)
    {
        [self.accountArray removeObject:model];
        [self reloadMyTableView];
        [manager deleteAccountListByModel:model];
        if (model.isCollect) {
            [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];
        }
    }
    

}


/**
 收藏  取消收藏
 */
-(void)collectAccount:(ClassificationModel *)model AtIndexPath:(NSIndexPath *)indexPath
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];

    if (indexPath.section == 0) {
        [manager updataNotesListByModel:model];
        [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];

    }
    else if (indexPath.section ==1)
    {
        [manager updataAccountListByModel:model];
        [[NSNotificationCenter defaultCenter]postNotificationName:kReloadCollect_Noti object:nil];
    }

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
    
    detailVC.preferredContentSize = CGSizeMake(IPHONE_WIDTH*0.9, IPHONE_HEIGHT*0.9);
    
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
