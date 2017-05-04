//
//  DetailCopyView.m
//  XuanYuan
//
//  Created by King on 2017/4/27.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "DetailCopyView.h"
#import "DetailCopyCell.h"
#import "DetailCopyViewToolBar.h"
#import "HYCollectViewAlignedLayout.h"
#import <CoreImage/CoreImage.h>

@interface DetailCopyView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionViewFlowLayout *_layout;
    UICollectionViewFlowLayout *_layoutleft;
}

@property (nonatomic,weak)UILabel *titleLabel;

@property (nonatomic,weak)UICollectionView *collectionView;

@property (nonatomic,strong)UICollectionViewFlowLayout *layout;

@property (nonatomic,strong)DetailCopyViewToolBar *toolBar;

@property (nonatomic,strong)NSMutableArray *bigbangDataArray;
@property (nonatomic,strong)NSMutableArray *dataArray;




@end

@implementation DetailCopyView

-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)bigbangDataArray
{
    if (_bigbangDataArray == nil) {
        _bigbangDataArray = [NSMutableArray array];
    }
    return _bigbangDataArray;
}

-(UICollectionViewFlowLayout *)layout
{
    if (self.isBigBang) {
        
        if (_layout == nil) {
            _layout = [[UICollectionViewFlowLayout alloc]init];
        }
        return _layout;
        
    }else
    {
        if (_layoutleft == nil) {
            _layoutleft = [[HYCollectViewAlignedLayout alloc]initWithType:HYCollectViewAlignLeft];
        }
        return _layoutleft;
    }
}


-(DetailCopyViewToolBar *)toolBar
{
    if (_toolBar == nil) {
        
        _toolBar = [[DetailCopyViewToolBar alloc]initWithFrame:CGRectZero];
        [_toolBar.leftButton addTarget:self action:@selector(swipLeft) forControlEvents:UIControlEventTouchUpInside];
        
        [_toolBar.rightButton addTarget:self action:@selector(swipRight) forControlEvents:UIControlEventTouchUpInside];
        
        [_toolBar.newlineButton addTarget:self action:@selector(newline) forControlEvents:UIControlEventTouchUpInside];
        
        [_toolBar.deleteButton addTarget:self action:@selector(deleteButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _toolBar;
}
-(void)swipLeft
{
    NSRange range = self.textView.selectedRange;
    if (range.location>0) {
        range.location -= 1;
    }
    self.textView.selectedRange = range;
}

-(void)swipRight
{
    NSRange range = self.textView.selectedRange;
    if (range.location<self.textView.text.length) {
        range.location += 1;
    }
    self.textView.selectedRange = range;
}

-(void)newline
{
    [self insertTextViewString:@"\n"];
    
    [self reloadButton];
}

-(void)deleteButton
{
    [self.textView deleteBackward];
    [self reloadButton];

}

-(void)insertTextViewString:(NSString *)string
{
//    我这里写这么一大推也是醉了,要不是昨天晚上突然想到苹果应该会给我提供插入字符的API 我还真就会一直这么写
//    NSRange range = self.textView.selectedRange;
//    NSMutableString *text = [[NSMutableString alloc]initWithString:self.textView.text];
//    [text insertString:string atIndex:range.location];
//    self.textView.text = [NSString stringWithFormat:@"%@",text];
//    range.location+=string.length;
//    self.textView.selectedRange = range;
    
    [self.textView insertText:string];
}

-(void)clickbigbang
{
    self.isBigBang = !self.isBigBang;

    
    
    [self.collectionView setCollectionViewLayout:self.layout];

}

-(void)setIsBigBang:(BOOL)isBigBang
{
    _isBigBang = isBigBang;
    [self reloadData];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configUI];

        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        
    }
    return self;
}

-(void)configUI
{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:16];
    titleLabel.textColor = MainTextWhiteColor;
    titleLabel.text = @"点击选择需要复制的文字";
    titleLabel.backgroundColor = MainRGB;//RGBA(34, 34, 34, 0.8);
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UIImage *image = [UIImage imageNamed:@"icon_shanchu_nor"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:image forState:UIControlStateNormal];
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [self addSubview:closeButton];
    _closeButton = closeButton;
    
    
    UIButton *bigbang = [UIButton buttonWithType:UIButtonTypeCustom];
    [bigbang setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [bigbang setTitle:@"分词" forState:UIControlStateNormal];
    bigbang.titleLabel.font = [UIFont systemFontOfSize:13];
    [bigbang setTitleColor:MainTextWhiteColor forState:UIControlStateNormal];
    [bigbang addTarget:self action:@selector(clickbigbang) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bigbang];
    _bigbang = bigbang;
    
    
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    collectionView.backgroundColor = MainTextWhiteColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[DetailCopyCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    
    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectZero];
    textView.layer.borderWidth = 1;
    textView.layer.cornerRadius = 5;
    textView.layer.borderColor = MainTextColor.CGColor;
    textView.textColor = MainTextColor;
    textView.tintColor = MainTextColor;
    textView.inputView = [UIView new];
    [textView becomeFirstResponder];
    [self addSubview:textView];
    _textView = textView;
    
    
    [self addSubview:self.toolBar];
    
    UIButton *copybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [copybtn setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [copybtn setTitle:@"复制" forState:UIControlStateNormal];
    [copybtn setTitleColor:MainTextColor forState:UIControlStateNormal];
    [copybtn setTitleColor:MainTextWhiteColor forState:UIControlStateHighlighted];
    [self addSubview:copybtn];
    _copybtn = copybtn;
    
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setBackgroundImage:[HTTools ht_createImageWithColor:MainTextColor] forState:UIControlStateHighlighted];
    [shareBtn setTitle:@"保存到" forState:UIControlStateNormal];
    [shareBtn setTitleColor:MainTextColor forState:UIControlStateNormal];
    [shareBtn setTitleColor:MainTextWhiteColor forState:UIControlStateHighlighted];
    [self addSubview:shareBtn];
    _shareBtn = shareBtn;

    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(40);
        
    }];
    
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.right.equalTo(titleLabel);

    }];
    
    [bigbang mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.left.equalTo(titleLabel);
        
    }];
    
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(40);
        make.centerX.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(300);
        
    }];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(collectionView.mas_bottom).offset(8);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-100);
        
    }];
    
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(textView.mas_bottom).offset(8);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(40);
        
    }];

    [copybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.toolBar.mas_bottom).offset(8);
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self);
        
    }];
    
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(copybtn.mas_top);
        make.left.equalTo(copybtn.mas_right);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self);
        make.width.equalTo(copybtn);
        
    }];
    
}

-(void)setModel:(ClassificationModel *)model
{
    _model = model;
    
    {
        [self.bigbangDataArray removeAllObjects];
        if (![HTTools ht_isBlankString:model.accountTitle]) {
            [self.bigbangDataArray addObject:@"标题:"];
            [self.bigbangDataArray addObject:model.accountTitle];
        }
        if (![HTTools ht_isBlankString:model.account]) {
            [self.bigbangDataArray addObject:@"账号:"];
            [self.bigbangDataArray addObject:model.account];
        }
        if (![HTTools ht_isBlankString:model.passWord]) {
            [self.bigbangDataArray addObject:@"密码:"];
            [self.bigbangDataArray addObject:model.passWord];
        }

        
        for (infoPassModel *info in model.infoPassWord) {
            [self.bigbangDataArray addObject:info.info_pass_Text];
            [self.bigbangDataArray addObject:info.info_password];
        }
        
        NSArray *arr = [HTTools stringTokenizerWithWord:model.remarks];
        if (arr.count>0) {
            [self.bigbangDataArray addObject:@"备注:"];
            [self.bigbangDataArray addObjectsFromArray:arr];
        }
        
//        [self.bigbangDataArray addObject:@","];
//        [self.bigbangDataArray addObject:@"."];
//        [self.bigbangDataArray addObject:@":"];
//        [self.bigbangDataArray addObject:@"\""];
//        [self.bigbangDataArray addObject:@";"];
//        [self.bigbangDataArray addObject:@"空格"];

    }
    {
        [self.dataArray removeAllObjects];
       
        if (![HTTools ht_isBlankString:model.accountTitle])
        {
            [self.dataArray addObject:[NSString stringWithFormat:@"标题:%@",model.accountTitle]];
        }
        if (![HTTools ht_isBlankString:model.account])
        {
            [self.dataArray addObject:[NSString stringWithFormat:@"账号:%@",model.account]];
        }
        if (![HTTools ht_isBlankString:model.passWord])
        {
            [self.dataArray addObject:[NSString stringWithFormat:@"密码:%@",model.passWord]];
        }
        for (infoPassModel *info in model.infoPassWord) {
            [self.dataArray addObject:[NSString stringWithFormat:@"%@:%@",info.info_pass_Text,info.info_password]];
        }
        if (![HTTools ht_isBlankString:model.remarks])
        {
            [self.dataArray addObject:[NSString stringWithFormat:@"备注:%@",model.remarks]];
        }
    }
    
}

-(void)reloadData
{

    [self.collectionView reloadData];

}

-(void)reloadButton
{
    if (self.textView.text.length>0) {
        UIColor *color = MainRGB;
        [self.copybtn setTitleColor:color forState:UIControlStateNormal];
        [self.shareBtn setTitleColor:color forState:UIControlStateNormal];
    }else{
        [self.copybtn setTitleColor:MainTextColor forState:UIControlStateNormal];
        [self.shareBtn setTitleColor:MainTextColor forState:UIControlStateNormal];

    }
}

#pragma -mark-  代理数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.isBigBang) {
        
        return self.bigbangDataArray.count;

    }else
    {
        return self.dataArray.count;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.isBigBang?self.bigbangDataArray[indexPath.item]:self.dataArray[indexPath.item];
    
    DetailCopyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.text = text;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCopyCell *cell = (DetailCopyCell *)[collectionView cellForItemAtIndexPath:indexPath];

    [self insertTextViewString:cell.text];
    [self reloadButton];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCopyCell *cell = (DetailCopyCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = MainRGB;
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCopyCell *cell = (DetailCopyCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.isBigBang?self.bigbangDataArray[indexPath.item]:self.dataArray[indexPath.item];
    CGSize size = [HTTools sizeOfString:text font:[UIFont boldSystemFontOfSize:15] width:self.frame.size.width-46];
    if (size.width<30) {
        size.width = 30;
    }
    return CGSizeMake(size.width+20, size.height+10);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}




@end
