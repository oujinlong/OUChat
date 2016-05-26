//
//  BasicViewController.h
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "ConstDefine.h"
#import "WeChatStyle.h"
#import "MBProgressHUD+MJ.h"
#import "EMSDK.h"
#import "HTTP.h"
#import "UserModel.h"
#import "Session.h"
#import "EaseUI.h"
@interface BasicViewController : UIViewController

@property (nonatomic, strong) UserModel* userModel;
/**
 *  添加导航栏右侧按钮
 *
 *  @param image  图片
 *  @param target 调用
 *  @param action 调用
 */
-(void)setRightItmeWithImage:(NSString*)image target:(id)target action:(SEL)action;

/**
 *  设置导航栏返回按钮
 *
 *  @param title 返回上一级的文字
 */
-(void)setBackItemWithTitle:(NSString*)title;

/**
 *  设置导航栏右侧纯文字item
 *
 *  @param title  标题
 *  @param target 响应
 *  @param action 响应
 */
-(void)setRightItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;


-(void)showAlertWithTitle:(NSString*)title SubmintTitle:(NSString*)submitTitle message:(NSString*)message submitHandle:(void(^)())handle;
@end
