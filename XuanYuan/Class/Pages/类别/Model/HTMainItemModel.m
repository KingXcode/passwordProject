//
//  HTMainItemModel.m
//  XuanYuan
//
//  Created by King on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTMainItemModel.h"
#import "HTDataBaseManager.h"
#import "MJExtension.h"

@implementation infoPassModel



@end



@interface HTMainItemModel()

@end

@implementation HTMainItemModel

-(NSString *)remarks
{
    if (_remarks == nil) {
        
        return @"";
        
    }else
    {
        return _remarks;
    }
}

+ (NSDictionary *)mj_objectClassInArray
{
    return  @{@"infoPassWord":@"infoPassModel"};
}

+(NSArray *)getMainModelArray
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    NSArray *list = [manager getAccountList];
    NSArray *newArray = [[self class] mj_objectArrayWithKeyValuesArray:list];
    newArray = [HTTools ht_SortModelArrar:newArray info:@{@"ID.integerValue":[NSNumber numberWithBool:NO]}];
    return newArray;
}


+(NSArray *)getCollectModelArray
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    NSArray *list = [manager getcollectList];
    NSArray *newArray = [[self class] mj_objectArrayWithKeyValuesArray:list];
    return newArray;
}

+(NSArray *)getNotesModelArray
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    NSArray *list = [manager getNotesList];
    NSArray *newArray = [[self class] mj_objectArrayWithKeyValuesArray:list];
    newArray = [HTTools ht_SortModelArrar:newArray info:@{@"ID.integerValue":[NSNumber numberWithBool:NO]}];
    return newArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *dataStr = [NSString stringWithFormat:@"%f",[NSDate date].timeIntervalSince1970*1000];
        _ID = [HTTools ht_DateWithLongTime:dataStr dateFormat:@"yyyyMMddHHmmss"];
        _infoPassWord = [NSMutableArray array];
        _isCollect = NO;//默认创建的时候是不被收藏的.
    }
    return self;
}


-(NSString *)getErrorHintString
{
    HTItemCheck check = [self checkAccountAndPassWord];
    NSString *hint;
    switch (check) {
        case HTItemCheckSucceed:
            break;
        case HTItemCheckErrorAll:
            hint = @"请正确输入数据";
            break;
        case HTItemCheckErrorTitle:
            hint = @"请输入标题!";
            break;
        case HTItemCheckErrorAccount:
            hint = @"请输入账号!";
            break;
        case HTItemCheckErrorPassWord:
            hint = @"请输入密码!";
            break;
        default:
            break;
    }
    return hint;
}

-(HTItemCheck)checkNotes
{
    BOOL checkRemark  = [HTTools ht_isBlankString:_remarks];
    
    if (checkRemark) {
        
        return HTItemCheckErrorAll;
        
    }else
    {
        return HTItemCheckSucceed;
    }
    
}

-(HTItemCheck)checkAccountAndPassWord
{
    BOOL checkTitle   = [HTTools ht_isBlankString:_accountTitle];
    BOOL checkAccount = [HTTools ht_isBlankString:_account];
    BOOL checkPassW   = [HTTools ht_isBlankString:_passWord];
    
    if (checkAccount&&checkPassW&&checkTitle) {
        
        return HTItemCheckErrorAll;
        
    }else if (checkTitle)
    {
        return HTItemCheckErrorTitle;
        
    }else if (checkAccount)
    {
        return HTItemCheckErrorAccount;
        
    }else if (checkPassW)
    {
        return HTItemCheckErrorPassWord;
        
    }else
    {
        return HTItemCheckSucceed;
    }
}

-(void)saveObject
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];

    [manager updataAccountListByModel:self];
}

-(void)saveNotes
{
    HTDataBaseManager *manager = [HTDataBaseManager sharedInstance];
    [manager updataNotesListByModel:self];
}



@end
