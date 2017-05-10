//
//  HTRecordViewController.m
//  XuanYuan
//
//  Created by King on 2017/5/4.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTRecordViewController.h"
#import "HTCheckPasswordErrorModel.h"
#import "HTAccessView.h"
#import "HTDataBaseManager.h"

@interface HTRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSMutableArray<HTCheckPasswordErrorModel *> *dataArray;

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,weak) HTAccessView *headView;

@end

@implementation HTRecordViewController

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        NSArray *array = [HTCheckPasswordErrorModel getModelArray];
        _dataArray = [NSMutableArray arrayWithArray:array];
    }
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat height = 230;
    
    HTAccessView *headView = [HTAccessView loadView];
    headView.frame = CGRectMake(0, 64, self.view.bounds.size.width, height);
    [self.view addSubview:headView];
    
    
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height+64, self.view.bounds.size.width, self.view.bounds.size.height-height-64) style:UITableViewStylePlain];
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    
    [tableView cyl_reloadData];
    self.tableView = tableView;
  
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




#pragma -mark-  tableView 数据源代理

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    HTCheckPasswordErrorModel *model = self.dataArray[indexPath.row];
    UIImage *image = [HTCheckPasswordErrorModel stringToImage:model.imageString];
    
    cell.imageView.image = image;
    
    cell.textLabel.text = model.location;
    
    cell.detailTextLabel.text = model.dateString;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView = cell.imageView;
    [[JJPhotoManeger maneger]showLocalPhotoViewer:@[imageView] selecView:imageView];

}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeakSelf(self);
    HTCheckPasswordErrorModel *model = self.dataArray[indexPath.row];
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [weakself deleteRecord:model];
    }];
    
    return @[action];
    
}

-(void)deleteRecord:(HTCheckPasswordErrorModel *)model
{
    
    [self.dataArray removeObject:model];
    [self.tableView cyl_reloadData];
    
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    [manager deleteErrorPasswordWarningListByModel:model];
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.dataArray.count<=0) {
        return nil;
    }
    return @"记录";
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
