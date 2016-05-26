//
//  HTTP.h
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMSDK.h"
@interface HTTP : NSObject
+(instancetype)sharedHTTP;

/**
 *  注册用户
 *
 *  @param userName 用户名
 *  @param password 密码
 *
 *
 *  环信只提供了同步的方法
 */
-(void)registWithUserName:(NSString*)userName password:(NSString*)password success:(void(^)())success failed:(void(^)(EMError* error))failed;

/**
 *  登录
 *
 *  @param userName 用户名
 *  @param password 密码
 *  @param success  成功回调
 *  @param failed   失败回调
 */
-(void)loginWithUserName:(NSString*)userName password:(NSString*)password success:(void(^)())success failed:(void(^)(EMError*))failed;

/**
 *  上传并保存头像
 *
 *  @param image   头像文件
 *  @param success 成功回调
 *  @param failed  失败回调
 */
-(void)uploadAvatarWithImage:(UIImage*)image success:(void(^)())success failed:(void(^)(EMError*))failed;

/**
 *  更新用户信息
 *
 *  @param nickName 昵称
 *  @param address  地址
 *  @param gender   性别
 *  @param region   地区
 *  @param sign     签名
 *  @param success  成功回调
 *  @param failed   失败回调
 */
-(void)updateNickName:(NSString*)nickName address:(NSString*)address gender:(NSString*)gender region:(NSString*)region sign:(NSString*)sign success:(void(^)())success failed:(void(^)())failed;

/**
 *  登出操作
 *
 *  @param success 成功回调
 *  @param failed  失败回调
 */
-(void)logoutSuccess:(void(^)())success failed:(void(^)(EMError*))failed;


-(void)fetchBuddyListSuccess:(void(^)())success failed:(void(^)(EMError*))failed;

@end
