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

@interface HTRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy) NSArray<HTCheckPasswordErrorModel *> *dataArray;

@property (nonatomic,weak) UITableView *tableView;

@property (nonatomic,weak) HTAccessView *headView;

@end

@implementation HTRecordViewController

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [HTCheckPasswordErrorModel getModelArray];
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
    
    UIImage *newImage = [HTTools ht_returnImage:image BySize:CGSizeMake(40*image.size.width/image.size.height, 40)];
    
    cell.imageView.image = newImage;
    
    cell.textLabel.text = model.location;
    
    cell.detailTextLabel.text = model.dateString;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

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
