//
//  ProfileDetailViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AvatarChangeViewController.h"
#import "UserInfoChangeViewController.h"
#import "GenderChangeViewController.h"
#import "MyCodeViewController.h"
@interface ProfileDetailViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView* tableView;
@property (nonatomic, weak) UIImageView* avatarImageView;
@end

@implementation ProfileDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNav];
    
    [self setupMain];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}
- (void)setupNav {
    self.title = @"个人信息";
    
    
    
}

-(void)setupMain{
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate =self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
#pragma mark cell 布局
-(void)setupCellForTopIconCell:(UITableViewCell*)cell{
    cell.textLabel.text = @"头像";
    
    UIImageView* avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView = avatarImageView;
    [cell.contentView addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(63, 63));
    }];
    avatarImageView.layer.cornerRadius = 8;
    avatarImageView.layer.masksToBounds = YES;
        [avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.portrait]];
    NSLog(@"%@",self.userModel.portrait);
}

-(void)setupCellForQRColdeCell:(UITableViewCell*)cell{
    cell.textLabel.text = @"我的二维码";
    UIImageView* codeImageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:codeImageView];
    [codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    codeImageView.image = [UIImage imageNamed:@"setting_myQR"];
    
    
}

-(NSString*)titleForCellIndexPath:(NSIndexPath*)indexPath{
    NSString* str = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            str = @"名字";
        }else if (indexPath.row == 2){
            str = @"微信号";
        }else if (indexPath.row == 3){
            str = @"我的二维码";
        }else{
            str = @"我的地址";
        }
    }else{
        if (indexPath.row == 0) {
            str = @"性别";
        }else if (indexPath.row == 1){
            str = @"地区";
        }else{
            str = @"个性签名";
        }
    }
    
    return str;
}


-(NSString*)subTitleForCellIndexPath:(NSIndexPath*)indexPath{
    NSString* str = nil;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            str = self.userModel.nickName;
        }else if (indexPath.row == 2){
            str = self.userModel.userName;
        }else if (indexPath.row == 3){
            
        }else{
            str = self.userModel.address;
        }
    }else{
        if (indexPath.row == 0) {
            str = self.userModel.gender;
        }else if (indexPath.row == 1){
            str = self.userModel.region;
        }else{
            str = self.userModel.sign;
        }
    }
    
    return str;

}

#pragma mark <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else{
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self setupCellForTopIconCell:cell];
    }else if (indexPath.section != 0 || indexPath.row != 3){
        //sub title
        NSString* title =  [self titleForCellIndexPath:indexPath];
        NSString* subTitle = [self subTitleForCellIndexPath:indexPath];
        
        cell.textLabel.text = title;
        cell.detailTextLabel.text = subTitle;
        
    }else{
        //二维码图片
        [self setupCellForQRColdeCell:cell];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row != 2) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0  && indexPath.row == 0) {
        return 77;
    }else{
        return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 3;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController* vc = nil;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //头像
            vc = [[AvatarChangeViewController alloc] init];
        }else if (indexPath.row == 1){
            //名字
            vc = [[UserInfoChangeViewController alloc] initWithType:UserInfoChangeViewControllerTypeNickName];
        }else if (indexPath.row == 3){
            //二维码
            vc = [[MyCodeViewController alloc] init];
            
        }else if (indexPath.row == 4){
            //我的地址
            vc = [[UserInfoChangeViewController alloc] initWithType:UserInfoChangeViewControllerTypeAddress];
        }
    }else{
        if (indexPath.row == 0) {
            //性别
            vc = [[GenderChangeViewController alloc] init];
            
        }else if (indexPath.row == 1){
            //地区
            vc = [[UserInfoChangeViewController alloc] initWithType:UserInfoChangeViewControllerTypeRegion];
        }else{
            //个性签名
            vc = [[UserInfoChangeViewController alloc] initWithType:UserInfoChangeViewControllerTypeSign];
        }
    
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
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
