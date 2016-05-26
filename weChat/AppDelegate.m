//
//  AppDelegate.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "AppDelegate.h"
#import "EMSDK.h"
#import "WeChatTabbarController.h"
#import "LoginViewController.h"
#import "IQKeyBoardManager.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UserModel.h" 
#import "EaseUI.h"
@interface AppDelegate () <EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    [self registEaseMob];
    
    [self registAVCloud];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    
    
    [self setupAutoLogin];
    
    [self.window makeKeyAndVisible];
    
    
    //设置键盘自动
    [IQKeyBoardManager installKeyboardManager];
    [IQKeyBoardManager setTextFieldDistanceFromKeyboard:50];
    
    
    //注册 UI
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:@"oujinlong#ouchat"
                                       apnsCertName:nil
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:NO]}];
    
    return YES;
}

/**
 *  注册环信
 */
-(void)registEaseMob{
    //注册环信
    
    EMOptions* options = [EMOptions optionsWithAppkey:@"oujinlong#ouchat"];
    
    
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
 
    
    
    
}
/**
 *  注册 LeanCloud
 */
-(void)registAVCloud{
    [AVOSCloud setApplicationId:@"9kGG7b8OpGGq2M4Vi8GzOyx8" clientKey:@"FsAOos1cwof9eTzzPG9SsElV"];
    
       
    
}
/**
 *  设置 tabbar
 */
-(void)setupTabbar{
    
    WeChatTabbarController* tabbarVc = [[WeChatTabbarController alloc] init];
    
    self.window.rootViewController = tabbarVc;
    
}

/**
 *  配置自动登录
 */
-(void)setupAutoLogin{

    
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    
    if (isAutoLogin) {
        [self setupTabbar];
    }else{
        
        [self enterLogin];
    }
    
    
  
}

/**
 *  进入登录界面
 */
-(void)enterLogin{
    LoginViewController* loginVc = [[LoginViewController alloc] init];
    
    self.window.rootViewController = loginVc;
    
    typeof(self)weakSelf = self;
    
    [loginVc setLoginSuccessBlock:^{
        
        [weakSelf setupTabbar];
        
    }];

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EMClient sharedClient] applicationDidEnterBackground:application];

    [UserModel clearTable];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark EMDelegate
-(void)didAutoLoginWithError:(EMError *)aError{
    if (!aError) {
        NSLog(@"自动登录成功");
        
        
        NSString* userName = [[NSUserDefaults standardUserDefaults] valueForKey:USER_NAME_KEY];
        
        if (userName) {
            [UserModel UserModelWithEaseMobUserName:userName isUpdate:NO hanlde:^(UserModel *userModel) {
                [Session sharedSession].currentUserModel = userModel;
            }];
        }else{
            [MBProgressHUD showError:@"请重新登录"];
            
            [self enterLogin];
        }
       
        
        //同步好友
        [[HTTP sharedHTTP] fetchBuddyListSuccess:^{
            
        } failed:^(EMError * error) {
            
        }];
        
    }else{
        
        [MBProgressHUD showError:@"请重新登录"];
        
        [self enterLogin];
        
    }
}

@end
