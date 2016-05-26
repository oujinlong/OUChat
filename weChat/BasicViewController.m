//
//  BasicViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "BasicViewController.h"
@interface BasicViewController ()

@end

@implementation BasicViewController
- (UserModel *)userModel
{
//    if (!_userModel) {
        _userModel = [Session sharedSession].currentUserModel;
//    }
    return _userModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    //注册键盘通知手势收键盘
    [self setupKeyboardNotification];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

-(void)setBackItemWithTitle:(NSString *)title{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 30, 25);
    [button setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)setRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:target action:action];
    item.tintColor = [WeChatStyle currentStyle].mainGreen;
    
    self.navigationItem.rightBarButtonItem = item;
}
#pragma mark 键盘
-(void)setupKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardWillShowNotification object:nil];
}
-(void)keyboardShow{
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)]];
}

-(void)hideKeyboard:(UITapGestureRecognizer*)gr{
    [self.view removeGestureRecognizer:gr];
    [self.view endEditing:YES];
}

-(void)setRightItmeWithImage:(NSString *)image target:(id)target action:(SEL)action{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:target action:action];
    self.navigationItem.rightBarButtonItem = item;
}

-(void)showAlertWithTitle:(NSString *)title SubmintTitle:(NSString *)submitTitle message:(NSString *)message submitHandle:(void (^)())handle{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* submit = [UIAlertAction actionWithTitle:submitTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        handle();
    }];
    
    UIAlertAction* cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:submit];
    [alert addAction:cancle];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    
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
