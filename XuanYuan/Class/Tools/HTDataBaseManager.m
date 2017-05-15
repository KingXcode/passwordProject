//
//  HTDataBaseManager.m
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/18.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import "HTDataBaseManager.h"
#import "HTEncryptionAndDecryption.h"



@interface HTDataBaseManager ()

@property (nonatomic,strong) YTKKeyValueStore *store;


@property (nonatomic,copy) NSString *accountList;

@property (nonatomic,copy) NSString *notesList;


@property (nonatomic,copy) NSString *errorPasswordWarningList;//入侵记录表


@end

@implementation HTDataBaseManager

+(void)load
{
    [super load];
    [HTDataBaseManager sharedInstance];
}

//实例化单例
+(HTDataBaseManager *)sharedInstance{
    
    static HTDataBaseManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTDataBaseManager alloc] init];
    });
    
    return manager;
}

-(instancetype)init{
    if (self = [super init]) {
        //创建数据库文件
        NSString *path = [[HTTools ht_sandbox_getLibrary_Cache] stringByAppendingPathComponent:@"weimiData.db"];
        _store = [[YTKKeyValueStore alloc] initWithDBWithPath:path];
        
        //创建 账号信息表
        _accountList = @"accountList_table";
        [_store createTableWithName:_accountList];
        
        //创建 备忘录表
        _notesList = @"notesList_table";
        [_store createTableWithName:_notesList];
        

        //入侵记录表
        _errorPasswordWarningList = @"errorPasswordWarningList";
        [_store createTableWithName:_errorPasswordWarningList];
        
    }
    return self;
}


//删除
-(void)deleteAccountListByModel:(HTMainItemModel *)model
{
    [_store deleteObjectById:model.ID fromTable:_accountList];
}


//更新/写入数据
-(void)updataAccountListByModel:(HTMainItemModel *)model
{
    NSDictionary *modelDict = model.mj_keyValues;
    
    NSDictionary *newModelDict = [HTEncryptionAndDecryption EncryptionDict:modelDict];

    [_store putObject:newModelDict withId:model.ID intoTable:_accountList];
}





//获取搜素信息
-(NSArray*)getAccountList
{
    NSArray *arr = [_store getAllItemsFromTable:_accountList];
    
    NSMutableArray *newList = [NSMutableArray array];
    
    for (YTKKeyValueItem *item in arr) {
        if ([item.itemObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = item.itemObject;
            
            NSDictionary *newDict = [HTEncryptionAndDecryption DecryptionDict:dict];
            
            [newList addObject:newDict];
            
        }
        
    }
    return newList;
}

-(NSArray*)getcollectList
{
    NSArray *collectArr = [_store getAllItemsFromTable:_accountList];
    NSArray *notesArr   = [_store getAllItemsFromTable:_notesList];
    NSMutableArray *newList = [NSMutableArray array];
    
    for (YTKKeyValueItem *item in collectArr) {
        NSDictionary *dict = item.itemObject;
        NSDictionary *newDict = [HTEncryptionAndDecryption DecryptionDict:dict];

        if ([newDict[@"isCollect"] boolValue] == YES) {
            [newList addObject:newDict];
        }
    }
    
    for (YTKKeyValueItem *item in notesArr) {
        NSDictionary *dict = item.itemObject;
        NSDictionary *newDict = [HTEncryptionAndDecryption DecryptionDict:dict];
        
        if ([newDict[@"isCollect"] boolValue] == YES) {
            [newList addObject:newDict];
        }
    }
    
    return newList;
}



//清空Search表
-(void)clearAccountList
{
    [_store clearTable:_accountList];
}



-(void)updataErrorPasswordWarningListByModel:(HTCheckPasswordErrorModel *)model
{
    NSMutableDictionary *modelDict = model.mj_keyValues;
    
    NSDictionary *newModelDict = [HTEncryptionAndDecryption EncryptionDict:modelDict];
    
    [_store putObject:newModelDict withId:model.ID intoTable:_errorPasswordWarningList];
}

-(void)deleteErrorPasswordWarningListByModel:(HTCheckPasswordErrorModel *)model
{
    [_store deleteObjectById:model.ID fromTable:_errorPasswordWarningList];
}

-(NSArray*)getErrorPasswordWarningList
{
    NSArray *arr = [_store getAllItemsFromTable:_errorPasswordWarningList];
    
    NSMutableArray *newList = [NSMutableArray array];
    
    for (YTKKeyValueItem *item in arr) {
        if ([item.itemObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = item.itemObject;
            
            NSDictionary *newDict = [HTEncryptionAndDecryption DecryptionDict:dict];
            
            [newList addObject:newDict];
            
        }
        
    }
    return newList;
}
-(void)clearErrorPassword
{
    [_store clearTable:_errorPasswordWarningList];
}













-(void)updataNotesListByModel:(HTMainItemModel *)model
{
    NSMutableDictionary *modelDict = model.mj_keyValues;
    
    NSDictionary *newModelDict = [HTEncryptionAndDecryption EncryptionDict:modelDict];
    
    [_store putObject:newModelDict withId:model.ID intoTable:_notesList];
}

-(void)deleteNotesListByModel:(HTMainItemModel *)model
{
    [_store deleteObjectById:model.ID fromTable:_notesList];
}

-(NSArray*)getNotesList
{
    NSArray *arr = [_store getAllItemsFromTable:_notesList];
    
    NSMutableArray *newList = [NSMutableArray array];
    
    for (YTKKeyValueItem *item in arr) {
        if ([item.itemObject isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *dict = item.itemObject;
            
            NSDictionary *newDict = [HTEncryptionAndDecryption DecryptionDict:dict];
            
            [newList addObject:newDict];
            
        }
        
    }
    return newList;
}
-(void)clearNotesList
{
    [_store clearTable:_notesList];
}







@end
