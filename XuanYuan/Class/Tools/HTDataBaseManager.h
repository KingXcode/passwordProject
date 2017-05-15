//
//  HTDataBaseManager.h
//  XuanYuan
//
//  Created by 聂嗣洋 on 2017/4/18.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HTMainItemModel.h"
#import "HTCheckPasswordErrorModel.h"

@interface HTDataBaseManager : NSObject

+(HTDataBaseManager *)sharedInstance;



//更新/写入数据
-(void)updataAccountListByModel:(HTMainItemModel *)model;
-(void)deleteAccountListByModel:(HTMainItemModel *)model;
//获取搜素信息
-(NSArray*)getAccountList;
-(NSArray*)getcollectList;
//清空Search表
-(void)clearAccountList;


-(void)updataErrorPasswordWarningListByModel:(HTCheckPasswordErrorModel *)model;
-(void)deleteErrorPasswordWarningListByModel:(HTCheckPasswordErrorModel *)model;
-(NSArray*)getErrorPasswordWarningList;
-(void)clearErrorPassword;






-(void)updataNotesListByModel:(HTMainItemModel *)model;
-(void)deleteNotesListByModel:(HTMainItemModel *)model;
-(NSArray*)getNotesList;
-(void)clearNotesList;


@end
