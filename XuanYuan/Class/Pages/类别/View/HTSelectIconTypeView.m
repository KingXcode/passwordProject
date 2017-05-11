//
//  HTSelectIconType.m
//  XuanYuan
//
//  Created by King on 2017/5/1.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTSelectIconTypeView.h"
#import "HTSelectIconTypeCell.h"

@interface HTSelectIconTypeView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,weak)UIImageView *iconView;
@property (nonatomic,weak)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HTSelectIconTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatUI];
        
    }
    return self;
}

-(void)setTypeIcon:(NSInteger)typeIcon
{
    
    _typeIcon = typeIcon;
    _iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%ld",(long)_typeIcon]];
                       
}

-(void)creatUI
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_0"]];
    [imageView ht_setCornerRadius:5];
    [imageView ht_setBorderWidth:1 Color:MainTextColor];
    [self addSubview:imageView];
    _iconView = imageView;
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:@"HTSelectIconTypeCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self).offset(8);
        make.height.width.mas_equalTo(84);
        
    }];
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(imageView.mas_right);
        
    }];
    
}

#define kTypeImageCount 20
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
        for (int i = 0; i<=kTypeImageCount; i++) {
            
            [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];
            
        }
        
    }
    return _dataArray;
}

#pragma -mark-  UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *type = self.dataArray[indexPath.item];
    
    HTSelectIconTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"type_%@",type]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *type = self.dataArray[indexPath.item];
    if (self.didselectIcon) {
        self.didselectIcon(type);
    }
    self.typeIcon = type.integerValue;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTSelectIconTypeCell *cell = (HTSelectIconTypeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
   

}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    HTSelectIconTypeCell *cell = (HTSelectIconTypeCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.transform = CATransform3DIdentity;
}



#pragma -mark-  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(38, 38);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

@end
