//
//  ConstDefine.h
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <Foundation/Foundation.h>
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define LOG_FUN     NSLog(@"%s",__func__)

#define USER_CLASS_KEY @"user"
#define USER_NAME_KEY @"userName"
#define USER_PASSWORD_KEY @"password"
#define USER_PORTRAIT_KEY @"portrait"
#define USER_NICKNAME_KEY @"nickName"
#define USER_GENDER_KEY @"gender"
#define USER_REGION_KEY @"region"
#define USER_SIGN_KEY @"sign"
#define USER_ADDRESS_KEY @"address"


#define MESSAGE_PORTRAIT_EXT_KEY @"portrait"

@interface ConstDefine : NSObject

@end
