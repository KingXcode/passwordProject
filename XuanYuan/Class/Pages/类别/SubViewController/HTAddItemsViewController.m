//
//  HTAddItemsViewController.m
//  XuanYuan
//
//  Created by King on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTAddItemsViewController.h"

#import "HTAddItemsCell.h"
#import "HTAddItemsModel.h"
#import "HTSelectIconTypeView.h"

@interface HTAddItemsViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)HTMainItemModel *MainModel;


/**
 当点击右上角按钮 产生一个辅助密码cell的时候回同步产生这个数组中的一个元素
 */
@property (nonatomic,strong)NSMutableArray<infoPassModel *> *infoPassArray;
@property (nonatomic,strong)NSMutableArray *listArray;
@property (nonatomic,strong)UITableView    *listView;




/**
 确定保存按钮
 */
@property (nonatomic,strong)UIButton *sureButton;


/**
 添加一个
 */
@property (nonatomic,strong)UIButton *rightButton;


@end

@implementation HTAddItemsViewController

-(UIButton *)sureButton
{
    if (_sureButton == nil) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureButton setTitle:@"确认保存" forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[HTTools ht_createImageWithColor:MainRGB] forState:UIControlStateNormal];
        [_sureButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateDisabled];

        _sureButton.frame = CGRectMake(0, self.view.bounds.size.height-66, IPHONE_WIDTH, 66);
        _sureButton.enabled = NO;
        
        [_sureButton addTarget:self action:@selector(clickedSureBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}


-(UITableView *)listView
{
    if (_listView == nil) {
        CGRect frame = CGRectMake(0, 0, IPHONE_WIDTH, self.view.bounds.size.height-66);
        _listView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.backgroundColor = MainTableViewBackgroundColor;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_listView registerNib:[UINib nibWithNibName:@"HTAddItemsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        HTSelectIconTypeView *typeView = [[HTSelectIconTypeView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 100)];
      
        __weak typeof(self) __self = self;
        [typeView setDidselectIcon:^(NSString *type) {
            [__self selectIconType:type];
        }];
        
        _listView.tableHeaderView = typeView;
        _listView.tableFooterView = [UIView new];
    }
    return _listView;
}

-(void)selectIconType:(NSString *)type
{
    self.MainModel.iconType = type.integerValue;
    [self check];
}

-(NSMutableArray *)listArray
{
    if (_listArray == nil) {
        
        HTAddItemsModel *model1 = [[HTAddItemsModel alloc]init];
        model1.title = @"标题";
        model1.titlePlaceholder = @"请输入标题";
        model1.index = 1;
        
        HTAddItemsModel *model2 = [[HTAddItemsModel alloc]init];
        model2.title = @"账号";
        model2.titlePlaceholder = @"请输入账号";
        model2.index = 2;

        
        HTAddItemsModel *model3 = [[HTAddItemsModel alloc]init];
        model3.title = @"密码";
        model3.titlePlaceholder = @"请输入密码";
        model3.index = 3;

        
        HTAddItemsModel *model4 = [[HTAddItemsModel alloc]init];
        model4.title = @"备注";
        model4.titlePlaceholder = @"请输入备注";
        model4.index = 4;

        NSMutableArray *section0 = [NSMutableArray arrayWithObjects:model1, nil];
        NSMutableArray *section1 = [NSMutableArray arrayWithObjects:model2,model3, nil];
        NSMutableArray *section2 = [NSMutableArray arrayWithObjects:model4, nil];


        _listArray = [NSMutableArray arrayWithArray:@[
                                                      section0,
                                                      section1,
                                                      section2]
                                                     ];
        
    }
    return _listArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加账号";
    [self setRightButton];
    
    self.infoPassArray = [NSMutableArray array];
    
    self.MainModel = [[HTMainItemModel alloc]init];
    
    [self.view addSubview:self.listView];
    [self.view addSubview:self.sureButton];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.swipeBackEnabled = NO;
    [self.listView reloadDataWithDirectionType:ZPReloadAnimationDirectionBottom AnimationTimeNum:0.5 interval:0.05];

}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.navigationController.swipeBackEnabled = YES;
}

-(void)goBack
{
//    [self.navigationController.view.layer addAnimation:[HTTools createTransitionAnimationWithType:@"push" direction:@"fromBottom" time:0.4] forKey:nil];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 设置右上角加好按钮
 */
-(void)setRightButton
{
    UIImage *image = [UIImage imageNamed:@"button-add-按钮添加"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setBackgroundImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    
    button.bounds = CGRectMake(0, 0, 35, 35);
    button.tintColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(clickedRightButton) forControlEvents:UIControlEventTouchUpInside];
    self.rightButton = button;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}


/**
 右上角加号点击事件
 */
-(void)clickedRightButton
{
    [self.view endEditing:YES];
    [self addInfoPassWord];
    
//    PopoverAction *action1 = [PopoverAction actionWithImage:[UIImage imageNamed:@"write-写"]
//                                                      title:@"添加其它密码"
//                                                    handler:^(PopoverAction *action) {
//                                                        
//                                                        [self.view endEditing:YES];
//                                                        [self addInfoPassWord];
//                                                        
//                                                    }];
//
//    
//    PopoverView *popoverView = [PopoverView popoverView];
//    popoverView.style = PopoverViewStyleDefault;
//    popoverView.showShade = YES;
//    [popoverView showToView:self.rightButton withActions:@[action1]];
}


/**
 添加一行辅助密码
 */
-(void)addInfoPassWord
{
    __weak typeof(self) __self = self;
    NSArray *btnArr = @[@"支付密码",@"交易密码",@"自定义"];
    ALActionSheetView *sheet = [ALActionSheetView showActionSheetWithTitle:@"请选择密码类型" cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:btnArr handler:^(ALActionSheetView *actionSheetView, NSInteger buttonIndex) {
        
        if (buttonIndex == btnArr.count-1) {
            
            [__self showCustomAlert];
            
        }else{
            
            infoPassModel *info = [[infoPassModel alloc]init];
            info.info_pass_Text = btnArr[buttonIndex];
            info.info_password = @"";
            [__self.infoPassArray addObject:info];
            
            HTAddItemsModel *model = [[HTAddItemsModel alloc]init];
            model.title = btnArr[buttonIndex];
            model.titlePlaceholder = @"请输入密码";
            model.index = 9999;
            model.info = info;
            NSMutableArray *section1 = self.listArray[1];
            [section1 addObject:model];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section1.count-1 inSection:1];
            [__self.listView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
            
            
        }
    }];
    [sheet show];
}

-(void)showCustomAlert
{
    __weak typeof(self) __self = self;

    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.iconTintColor = [UIColor whiteColor];
    SCLTextView *textField = [alert addTextField:@"请输入类型名称"];
    [alert addButton:@"确定" actionBlock:^(void) {
        
        infoPassModel *info = [[infoPassModel alloc]init];
        info.info_pass_Text = textField.text;
        info.info_password = @"";
        [__self.infoPassArray addObject:info];
        
        HTAddItemsModel *model = [[HTAddItemsModel alloc]init];
        model.title = textField.text;
        model.titlePlaceholder = @"请输入密码";
        model.index = 9999;
        model.info = info;
        NSMutableArray *section1 = self.listArray[1];
        [section1 addObject:model];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section1.count-1 inSection:1];
        [__self.listView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        
    }];
    
    [alert showCustom:self.navigationController image:[UIImage imageNamed:@"edit-编辑"] color:MainRGB title:@"密码类型" subTitle:@"请输入自定义的密码类型" closeButtonTitle:@"取消" duration:0.0f];
}


/**
 移除一行辅助密码
 */
-(void)removeInfoPassWordFromIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *section1 = self.listArray[indexPath.section];
    [section1 removeObjectAtIndex:indexPath.row];
    
    HTAddItemsCell *cell = [self.listView cellForRowAtIndexPath:indexPath];    
    [self.infoPassArray removeObject:cell.model.info];
    [self.listView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self check];


}


/**
 点击保存按钮
 */
-(void)clickedSureBtn:(UIButton *)button
{
    [self saveDate];

    [self goBack];
    [[NSNotificationCenter defaultCenter]postNotificationName:kReloadClassification_Noti object:nil];
}


/**
 保存数据
 */
-(void)saveDate
{
    [self.MainModel.infoPassWord addObjectsFromArray:self.infoPassArray];
    [self.MainModel saveObject];
}


//MARK: - 滚动视图代理

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    if (scrollView.contentOffset.y<-160) {
        [self.view endEditing:YES];
        [self goBack];
    }
    
}

//MARK: - TableView代理方法

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) __self = self;
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [__self removeInfoPassWordFromIndexPath:indexPath];
    }];
    return @[action];
}




//MARK: - TableView数据源方法
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row>=2) {
        return YES;
    }else
    {
        return NO;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.listArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HTAddItemsModel *model = self.listArray[indexPath.section][indexPath.row];

    HTAddItemsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = model;
    __weak typeof(self) __self = self;
    [cell setDidEndEditing:^(NSString *text,NSInteger index,HTAddItemsModel *model) {
        [__self cellInputFinish:text Index:index Model:model];
    }];
    
    
    
    return cell;
}

-(void)cellInputFinish:(NSString *)text Index:(NSInteger)index Model:(HTAddItemsModel *)model
{
    switch (model.index) {
        case 1:
            self.MainModel.accountTitle = text;
            break;
        case 2:
            self.MainModel.account = text;
            break;
        case 3:
            self.MainModel.passWord = text;
            break;
        case 4:
            self.MainModel.remarks = text;
            break;
        case 9999:
            model.info.info_password = text;
            break;
        default:
            break;
    }
    
    [self check];

}

-(void)check
{
    HTItemCheck check = [self.MainModel checkAccountAndPassWord];
    if (check == HTItemCheckSucceed) {
        self.sureButton.enabled = YES;
    }else
    {
        self.sureButton.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
