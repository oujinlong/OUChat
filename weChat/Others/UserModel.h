//
//  UserModel.h
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tool_FMDBModel.h"

@interface UserModel : Tool_FMDBModel
+(void)UserModelWithEaseMobUserName:(NSString*)userName isUpdate:(BOOL)isupDate hanlde:(void(^)(UserModel* userModel))hanlde;

/**
 *  根据用户名和密码存在本地 （登录成功时用） 用来自动登录
 *
 *  @param userName 用户名
 *  @param password 密码
 */
+(void)saveUserForAutoLoginWithUserName:(NSString*)userName password:(NSString*)password;
/**
 *  读取本地存储的用户名和密码
 *
 *  @return 用户名和密码所对应的字典
 */
+(NSDictionary*)loadUserForAutoLogin;

/**
 *  清除本地存储的用户名和密码
 */
+(void)clearUserInfoForLocalAutoLogin;

/**
 *  更新本地信息
 *
 *  @param handle 回调
 */
+(void)updateForLocalHandle:(void(^)())handle;
/**
 *  leanCloud  对象的唯一标识
 */
@property (nonatomic, copy) NSString *objectID;
/**
 *  本应用 唯一标识
 */
@property (nonatomic, copy) NSString * userName;

/**
 *  头像地址
 */
@property (nonatomic, copy) NSString *portrait;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickName;

/**
 *  性别
 */
@property (nonatomic, copy) NSString *gender;

/**
 *  地区
 */
@property (nonatomic, copy) NSString *region;

/**
 *  签名
 */
@property (nonatomic, copy) NSString *sign;

/**
 *  地址
 */
@property (nonatomic, copy) NSString *address;

/**
 *  昵称拼音首字母
 */
@property (nonatomic, copy) NSString *Pinyin;
@end
