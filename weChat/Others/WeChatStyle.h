//
//  WeChatStyle.h
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatStyle : NSObject
+(instancetype)currentStyle;

/**
 *  tabbar 默认颜色
 */
@property (nonatomic, strong) UIColor* tabbarColor;

/**
 *  tabbar 选中颜色
 */
@property (nonatomic, strong) UIColor* tabbarSelectColor;


/**
 *  主题绿色
 */
@property (nonatomic, strong) UIColor* mainGreen;
@end
