//
//  LoginViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
#import "RegistViewController.h"
#import "WeChatNavigationController.h"
@interface LoginViewController () <EMClientDelegate>
@property (nonatomic, weak) LoginInputView* userNameView;
@property (nonatomic, weak) LoginInputView* passwordView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupMain];
    
     
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USER_NAME_KEY]) {
        NSDictionary* userDic = [UserModel loadUserForAutoLogin];
        [self.userNameView setText:[userDic valueForKey:USER_NAME_KEY]];
        [self.passwordView setText:[userDic valueForKey:USER_PASSWORD_KEY]];
        [self loginClick];
    }

}

-(void)setupMain{
    UIImageView* avatarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.jpg"]];
    [self.view addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(69);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    avatarImageView.layer.cornerRadius = 8;
    avatarImageView.layer.masksToBounds = YES;
    
    
    LoginInputView* userNameInput = [[LoginInputView alloc] initWithTitle:@"用户名" placeHolder:@"请输入用户名" isPassword:NO];
    
    self.userNameView = userNameInput;
    [self.view addSubview:userNameInput];
    [userNameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(avatarImageView.mas_bottom).offset(30);
        make.height.mas_equalTo(25);
    }];
    
    
    LoginInputView* passwordInput = [[LoginInputView alloc] initWithTitle:@"密码" placeHolder:@"请输入密码" isPassword:YES] ;
    self.passwordView = passwordInput;
    [self.view addSubview:passwordInput];
    [passwordInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(userNameInput);
        make.right.mas_equalTo(userNameInput);
        make.top.mas_equalTo(userNameInput.mas_bottom).offset(30);
        make.height.mas_equalTo(userNameInput);
    }];
    
    
    UIButton* loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[WeChatStyle currentStyle].mainGreen];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(passwordInput);
        make.top.mas_equalTo(passwordInput.mas_bottom).offset(20);
        make.height.mas_equalTo(35);
    }];
    loginButton.layer.cornerRadius = 8;
    loginButton.layer.masksToBounds = YES;
    [loginButton addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton* registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registButton setTitle:@"快速注册" forState:UIControlStateNormal];
    [registButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-20);
    }];
    [registButton addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}




#pragma mark button click
- (void)loginClick {
    LOG_FUN;
    typeof(self)weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[HTTP sharedHTTP] loginWithUserName:[self.userNameView getContentText] password:[self.passwordView getContentText] success:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showSuccess:@"登录成功"];
        });
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.loginSuccessBlock();
        });
        
    } failed:^(EMError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:error.errorDescription];
        });
        
    }];
}

-(void)registClick{
    LOG_FUN;
    
    WeChatNavigationController* vc = [WeChatNavigationController NavWithChildViewController:[[RegistViewController alloc] init]];
    
    [self presentViewController:vc animated:YES completion:nil];
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
