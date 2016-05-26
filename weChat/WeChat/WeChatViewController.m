//
//  WeChatViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "WeChatViewController.h"

@interface WeChatViewController ()

@end

@implementation WeChatViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"微信";
    
    [self setRightItmeWithImage:@"barbuttonicon_add" target:self action:@selector(rightItemClick)];
}
#pragma mark button click
- (void)rightItemClick {
    LOG_FUN;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
