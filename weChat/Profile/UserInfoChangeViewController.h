//
//  UserInfoChangeViewController.h
//  weChat
//
//  Created by oujinlong on 16/5/20.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "BasicViewController.h"

typedef enum{
    UserInfoChangeViewControllerTypeNickName,
    UserInfoChangeViewControllerTypeAddress,
    UserInfoChangeViewControllerTypeRegion,
    UserInfoChangeViewControllerTypeSign
}UserInfoChangeViewControllerType;
@interface UserInfoChangeViewController : BasicViewController
-(instancetype)initWithType:(UserInfoChangeViewControllerType)type;
@end
