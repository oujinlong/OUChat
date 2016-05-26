//
//  WeChatStyle.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "WeChatStyle.h"
#import "ConstDefine.h"
@implementation WeChatStyle
+(instancetype)currentStyle{
    
    static WeChatStyle* style = nil;
    static dispatch_once_t pre;
    dispatch_once(&pre, ^{
        style = [[WeChatStyle alloc] init];
    });
    
    return style;
    
}

- (UIColor *)tabbarColor
{
    if (!_tabbarColor) {
        _tabbarColor =  COLOR(140, 140, 140);
    }
    return _tabbarColor;
}

- (UIColor *)tabbarSelectColor
{
    if (!_tabbarSelectColor) {
        _tabbarSelectColor = COLOR(12, 185, 8);
    }
    return _tabbarSelectColor;
}

- (UIColor *)mainGreen
{
    if (!_mainGreen) {
        _mainGreen = COLOR(26, 165, 64);
    }
    return _mainGreen;
}


@end
