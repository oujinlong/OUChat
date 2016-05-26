//
//  WeChatTabbarController.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "WeChatTabbarController.h"
#import "WeChatViewController.h"
#import "FindViewController.h"
#import "FriendsViewController.h"
#import "ProfileViewController.h"
#import "WeChatNavigationController.h"
#import "WeChatStyle.h"
@interface WeChatTabbarController ()

@end

@implementation WeChatTabbarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupMain];
    }
    return self;
}

-(void)setupMain{
    
    [self addChild];
    
    [self setupImage];
}

/**
 *  添加子控制器
 */
-(void)addChild{
    
    EaseConversationListViewController *chatListVC = [[EaseConversationListViewController alloc] init];
    WeChatNavigationController* weChat = [WeChatNavigationController NavWithChildViewController:chatListVC];
    
    WeChatNavigationController* friends = [WeChatNavigationController NavWithChildViewController:[[FriendsViewController alloc] init]];
    
    WeChatNavigationController* find = [WeChatNavigationController NavWithChildViewController:[[FindViewController alloc] init]];
    
    WeChatNavigationController* profile = [WeChatNavigationController NavWithChildViewController:[[ProfileViewController alloc] init]];
    
    
    [self addChildViewController:weChat];
    [self addChildViewController:friends];
    [self addChildViewController:find];
    [self addChildViewController:profile];

}

-(void)setupImage{
    
    NSArray* imageArray = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    NSArray* selectImageArray = @[@"tabbar_mainframeHL",@"tabbar_contactsHL",@"tabbar_discoverHL",@"tabbar_meHL"];
    NSArray* titles = @[@"微信",@"通讯录",@"发现",@"我的"];
    NSInteger index = 0;
    for (UIViewController* vc in self.childViewControllers) {
        [vc.tabBarItem setImage:[[UIImage imageNamed:imageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setSelectedImage:[[UIImage imageNamed:selectImageArray[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [vc.tabBarItem setTitle:titles[index]];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [WeChatStyle currentStyle].tabbarColor} forState:UIControlStateNormal];
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [WeChatStyle currentStyle].tabbarSelectColor } forState:UIControlStateSelected];
        index ++;
    }

    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbarBkg"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
