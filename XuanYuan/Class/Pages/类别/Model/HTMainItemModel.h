//
//  HTMainItemModel.h
//  XuanYuan
//
//  Created by King on 2017/4/17.
//  Copyright © 2017年 聂嗣洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface infoPassModel : NSObject


/**
 辅助密码 标识符
 */
@property (nonatomic,copy) NSString *info_pass_ID;
/**
 辅助密码名称
 */
@property (nonatomic,copy) NSString *info_pass_Text;

/**
 辅助密码
 */
@property (nonatomic,copy) NSString *info_password;

@end


typedef NS_ENUM(NSUInteger, HTItemCheck) {
    HTItemCheckSucceed,
    HTItemCheckErrorAll,
    HTItemCheckErrorTitle,
    HTItemCheckErrorAccount,
    HTItemCheckErrorPassWord,

};

@interface HTMainItemModel : NSObject
@property (nonatomic,copy) NSString * ID;           //账号ID   正常不需要设置这个值

@property (nonatomic,copy) NSString * accountTitle; //标题  *******   必须不为空
@property (nonatomic,copy) NSString * account;      //账号  *******   必须不为空
@property (nonatomic,copy) NSString * passWord;     //密码  *******   必须不为空
@property (nonatomic,copy) NSString * remarks;      //备注            可以为空
@property (nonatomic,assign) BOOL isCollect;        //是否被收藏
@property (nonatomic,assign) NSInteger iconType;    //icon类型  默认为0;


/**
 辅助密码信息 例如:交易密码,其它非登录密码信息
 */
@property (nonatomic,strong) NSMutableArray<infoPassModel *> *infoPassWord;

/**
 验证输入是否为空
 */
-(HTItemCheck)checkNotes;
-(HTItemCheck)checkAccountAndPassWord;

/**
 验证有错误的情况下的提示信息
 */
-(NSString *)getErrorHintString;


/**
 将自身的数据保存进入数据库
 */
-(void)saveObject;


/**
 作为备忘录保存
 */
-(void)saveNotes;


/**
 获取数据库中的所有账号数据,并转化为模型数组
 */
+(NSArray *)getMainModelArray;
+(NSArray *)getCollectModelArray;
+(NSArray *)getNotesModelArray;



@end
