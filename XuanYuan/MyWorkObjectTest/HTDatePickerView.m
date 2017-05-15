//
//  HTDatePickerView.m
//  XuanYuan
//
//  Created by King on 2017/5/12.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTDatePickerView.h"
#import "HTDatePickerCell.h"


#define CollectionSpaceing 5
#define CellSizeWidth ((MyWidth-CollectionSpaceing*2)/4-1)
#define CellSizeHeight ((CollectionHeight-CollectionSpaceing*2)/3-1)
#define LineSpacing 0
#define InteritemSpacing 0

@interface HTDatePickerView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UIView *contentView;

@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UILabel *yearLabel;
@property (nonatomic,strong) UIButton *rightButton;

@property (nonatomic,weak)UICollectionView *collectionView;
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
@property (nonatomic,copy) NSArray *dataArray;

@property (nonatomic,copy)NSString *currentYear;
@property (nonatomic,copy)NSString *currentMonth;

@property (nonatomic,assign) NSInteger selectYear;
@property (nonatomic,assign) NSInteger selectMonth;



@end

@implementation HTDatePickerView


-(NSInteger)selectYear
{
    if (_selectYear<1970) {
        _selectYear = 1970;
    }
    if (_selectYear>self.currentYear.integerValue) {
        _selectYear=self.currentYear.integerValue;
    }
    return _selectYear;
}

-(NSInteger)selectMonth
{
    if (_selectMonth<1) {
        _selectMonth = 1;
    }
    if (_selectMonth>12) {
        _selectMonth=12;
    }
    return _selectMonth;
}

-(NSArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = @[@"1",
                       @"2",
                       @"3",
                       @"4",
                       @"5",
                       @"6",
                       @"7",
                       @"8",
                       @"9",
                       @"10",
                       @"11",
                       @"12"];
    }
    return _dataArray;
}

-(NSString *)currentYear
{
    if (_currentYear == nil) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *currentTime = [HTTools ht_DateWithLongTime:[NSString stringWithFormat:@"%f",time*1000] dateFormat:@"YYYY"];
        _currentYear = currentTime;
    }
    return _currentYear;
}

-(NSString *)currentMonth
{
    if (_currentMonth == nil) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        NSString *currentTime = [HTTools ht_DateWithLongTime:[NSString stringWithFormat:@"%f",time*1000] dateFormat:@"M"];
        _currentMonth = currentTime;
    }
    return _currentMonth;
}

-(void)clickedLeft
{
    
}


-(void)configUI
{
    
    UIView *contentView = [UIView new];
    contentView.backgroundColor = MainRGB;
    [self addSubview:contentView];
    _contentView = contentView;
    
    UILabel *yearLabel = [[UILabel alloc]init];
    yearLabel.text = [NSString stringWithFormat:@"%@年",self.currentYear];
    yearLabel.font = [UIFont boldSystemFontOfSize:16];
    yearLabel.textColor = [UIColor darkTextColor];
    yearLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:yearLabel];
    _yearLabel = yearLabel;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:@"左" forState:UIControlStateNormal];
    [self.contentView addSubview:leftButton];
    _leftButton = leftButton;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setTitle:@"右" forState:UIControlStateNormal];
    [self.contentView addSubview:rightButton];
    _rightButton = rightButton;
    
    _layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_layout];
    collectionView.backgroundColor = MainTextWhiteColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"HTDatePickerCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self.contentView addSubview:collectionView];
    _collectionView = collectionView;
    
    [self layoutUI];
}

//布局
-(void)layoutUI
{
    [_yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.right.equalTo(_yearLabel.mas_left).mas_offset(-8);
        make.height.with.equalTo(_yearLabel.mas_height);
        
    }];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.left.equalTo(_yearLabel.mas_right).mas_offset(8);
        make.height.with.equalTo(_yearLabel.mas_height);

    }];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_yearLabel.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.contentView);

    }];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
        self.backgroundColor = RGBA(34, 34, 34, 0.0);
        

        
    }
    return self;
}

+ (instancetype)pickerView
{
    return [[self alloc] init];
}

#define MyWidth IPHONE_WIDTH*0.6
#define MyHeight (MyWidth*3/4+30)
#define CollectionHeight (MyWidth*3/4)

-(void)showSelectYear:(NSInteger)year
             AndMonth:(NSInteger)month
               ToView:(UIView *)superView
             position:(CGPoint)point;
{
    self.selectYear = year;
    self.selectMonth = month;
    
    self.frame = CGRectMake(0, 0, superView.bounds.size.width, superView.bounds.size.height);
    
    self.contentView.layer.anchorPoint = CGPointMake(0.5, 0);
    CGFloat w = MyWidth;
    CGFloat h = MyHeight;
    self.contentView.center = point;
    self.contentView.bounds = CGRectMake(0, 0, w, h);
    
    [superView addSubview:self];
    [HTTools CATransform3DScaleVerticalView:self.contentView];
    [UIView animateWithDuration:.4f animations:^{
        self.backgroundColor = RGBA(34, 34, 34, 0.6);
    }];
}

#pragma -mark-  代理数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.dataArray[indexPath.item];
    
    HTDatePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell.dateButton setTitle:[NSString stringWithFormat:@"%@月",text] forState:UIControlStateNormal];
    

    [cell setEnable:!((self.yearLabel.text.integerValue == self.currentYear.integerValue)&&(text.integerValue>self.currentMonth.integerValue))];

    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.dataArray[indexPath.item];
    HTDatePickerCell *cell = (HTDatePickerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.enable) {
        NSLog(@"%@",text);
    }
}

-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTDatePickerCell *cell = (HTDatePickerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.enable) {
        cell.dateButton.backgroundColor = [UIColor darkGrayColor];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTDatePickerCell *cell = (HTDatePickerCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.dateButton.backgroundColor = [UIColor clearColor];

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat w = CellSizeWidth;
    CGFloat h = CellSizeHeight;
    return CGSizeMake(w, h);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CollectionSpaceing, CollectionSpaceing, CollectionSpaceing, CollectionSpaceing);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return LineSpacing;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return InteritemSpacing;
}



@end
