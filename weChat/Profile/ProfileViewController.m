//
//  ProfileViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileDetailViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
@interface ProfileViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray* imageSource;
@property (nonatomic, strong) NSArray* titleSource;
@property (nonatomic, weak) UIImageView* avatarImageView;
@property (nonatomic, weak) UILabel* nameLB;
@property (nonatomic, weak) UILabel* idLB;
@end

@implementation ProfileViewController
- (NSArray *)imageSource
{
    if (!_imageSource) {
        _imageSource = @[@[@"MoreMyAlbum",@"MoreMyFavorites",@"MoreMyBankCard",@"MoreMyBankCard"],@[@"MoreExpressionShops"],@[@"MoreSetting"]];
    
    }
    return _imageSource;
}

- (NSArray *)titleSource
{
    if (!_titleSource) {
        _titleSource = @[@[@"相册",@"收藏",@"钱包",@"卡券"],@[@"表情"],@[@"退出登录"]];
    }
    return _titleSource;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self reloadUserInfo];
}

-(void)reloadUserInfo{
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.portrait]];
    
    self.nameLB.text = self.userModel.nickName;
    
    self.idLB.text = [NSString stringWithFormat:@"微信号: %@",self.userModel.userName];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我";
    
    [self setupMain];
    
}

-(void)setupMain{
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark cell详情
-(void)createTopWithCell:(UITableViewCell*)cell{
    UIImageView* iconImageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(68, 68));
    }];
    iconImageView.layer.cornerRadius = 5;
    iconImageView.layer.masksToBounds = YES;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.portrait]];
    self.avatarImageView = iconImageView;
    
    UILabel* nameLB = [[UILabel alloc] init];
    nameLB.font = [UIFont systemFontOfSize:15];
    nameLB.textColor = [UIColor blackColor];
    [cell.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(iconImageView.mas_right).offset(10);
        make.top.mas_equalTo(iconImageView).offset(10);
    }];
    nameLB.text = self.userModel.nickName;
    self.nameLB = nameLB;
    
    UILabel* idLB = [[UILabel alloc] init];
    idLB.font = [UIFont systemFontOfSize:14];
    idLB.textColor = [UIColor blackColor];
    [cell.contentView addSubview:idLB];
    [idLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLB);
        make.top.mas_equalTo(nameLB.mas_bottom).offset(12);
    }];
    idLB.text =[NSString stringWithFormat:@"微信号: %@",self.userModel.userName];
    self.idLB = idLB;
    
    UIImageView* qrImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"setting_myQR"]];
    [cell.contentView addSubview:qrImageView];
    [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.mas_equalTo(0);
    }];
    
}

-(void)logOut{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HTTP sharedHTTP] logoutSuccess:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showSuccess:@"登出成功"];
        });
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            AppDelegate* appDe =  [UIApplication sharedApplication].delegate;
            [appDe enterLogin];
        });
            } failed:^(EMError *error) {
                
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"登出失败"];
        });

        
    }];
    
}
#pragma mark <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 1;
    if (section == 1) {
        count = 4;
    }
    
    return count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (indexPath.row == 0 && indexPath.section == 0) {
            [self createTopWithCell:cell];
        }else{
            
            UIImageView* iconImageView = [[UIImageView alloc] init];
            [cell.contentView addSubview:iconImageView];
            [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(22, 22));
            }];
            iconImageView.tag = 1;
            
            UILabel* label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor blackColor];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(iconImageView.mas_right).offset(18);
                make.centerY.mas_equalTo(iconImageView);
            }];
            label.tag = 2;

        
        }
        
    }
    if (indexPath.row != 0 || indexPath.section != 0) {
        UIImageView* imageView = [cell.contentView viewWithTag:1];
        imageView.image = [UIImage imageNamed:self.imageSource[indexPath.section - 1 ][indexPath.row]];
        
        UILabel* label = [cell.contentView viewWithTag:2];
        label.text = self.titleSource[indexPath.section - 1][indexPath.row];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 87;
    }else{
        return 44;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 ) {
        ProfileDetailViewController* vc = [[ProfileDetailViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.section == 3) {
        
        [self showAlertWithTitle:@"登出" SubmintTitle:@"确定" message:@"确定登出吗?" submitHandle:^{
            [self logOut];
        }];
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
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
