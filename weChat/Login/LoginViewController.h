//
//  LoginViewController.h
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "BasicViewController.h"

@interface LoginViewController : BasicViewController
@property (nonatomic, copy) void ((^loginSuccessBlock)());
@end
