//
//  MyCodeViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/20.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "MyCodeViewController.h"
#import "UIImageView+WebCache.h"
@interface MyCodeViewController ()

@end

@implementation MyCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的二维码";
    
    [self setupMain];
}

- (void)setupMain {
    
    self.view.backgroundColor = COLOR(47, 48, 50);
    
    UIView* mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mainView];
    
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width - 30, self.self.view.bounds.size.height - 200));
    }];
 
    UIImageView* avatarImageView = [[UIImageView alloc] init];
    [mainView addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(75, 75));
    }];
    [avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.portrait]];
    avatarImageView.layer.cornerRadius = 8;
    avatarImageView.layer.masksToBounds = YES;
    
    
    UILabel* nameLB = [[UILabel alloc] init];
    nameLB.font = [UIFont boldSystemFontOfSize:17];
    nameLB.textColor = [UIColor blackColor];
    [mainView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatarImageView.mas_right).offset(10);
        make.top.mas_equalTo(avatarImageView).offset(3);
    }];
    nameLB.text = self.userModel.nickName;
    
    UIImageView* genderImageView = [[UIImageView alloc] init];
    [mainView addSubview:genderImageView];
    [genderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLB.mas_right).offset(2);
        make.centerY.mas_equalTo(nameLB);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    genderImageView.image = [self.userModel.gender isEqualToString:@"男"] ? [UIImage imageNamed:@"Contact_Male"] : [UIImage imageNamed:@"Contact_Female"];
    
    
    UILabel* regionLB = [[UILabel alloc] init];
    regionLB.font = [UIFont systemFontOfSize:15];
    regionLB.textColor = [UIColor grayColor];
    [mainView addSubview:regionLB];
    [regionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLB);
        make.bottom.mas_equalTo(avatarImageView).offset(-15);
    }];
    regionLB.text = self.userModel.region;
    
    UIImageView* codeImageView = [[UIImageView alloc] init];
    [mainView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatarImageView);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(avatarImageView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-50);
    }];
    codeImageView.image = [UIImage imageNamed:@"MyCode"];
    
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor grayColor];
    [mainView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(codeImageView.mas_bottom).offset(10);
    }];
    label.text = @"扫一扫上面的二维码,加我微信";
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
