//
//  UserInfoChangeViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/20.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "UserInfoChangeViewController.h"

@interface UserInfoChangeViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITextField* textField;
@property (nonatomic, assign)UserInfoChangeViewControllerType type;
@end

@implementation UserInfoChangeViewController
-(instancetype)initWithType:(UserInfoChangeViewControllerType)type{
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setRightItemWithTitle:@"保存" target:self action:@selector(saveClick)];
    
    [self setupMain];
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)setupMain {
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
}

-(void)setupCell:(UITableViewCell*)cell{
    UITextField* textField = [[UITextField alloc] init];
    self.textField = textField;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [cell.contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 20);
        make.height.mas_equalTo(cell.contentView.mas_height).offset(-8);
    }];
    
    NSString* firstText = nil;
    
    if (self.type == UserInfoChangeViewControllerTypeNickName) {
        firstText = self.userModel.nickName;
        self.title = @"名字";
    }else if (self.type == UserInfoChangeViewControllerTypeAddress){
        firstText = self.userModel.address;
        self.title = @"地址";
    }else if (self.type == UserInfoChangeViewControllerTypeRegion){
        firstText = self.userModel.region;
        self.title = @"地区";
    }else if (self.type == UserInfoChangeViewControllerTypeSign){
        firstText = self.userModel.sign;
        self.title = @"个性签名";
    }
    
    textField.text = firstText;
}

#pragma mark UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [self setupCell:cell];
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

#pragma mark button click
-(void)saveClick{
    LOG_FUN;
    if (self.textField.text.length == 0 || self.textField.text == nil) {
        [MBProgressHUD showError:@"请输入内容后保存"];
        return;
    }
    
    [self.view endEditing:YES];
    NSString* content = self.textField.text;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HTTP sharedHTTP] updateNickName:self.type == UserInfoChangeViewControllerTypeNickName ? content:nil address:self.type == UserInfoChangeViewControllerTypeAddress ? content : nil gender:nil region:self.type == UserInfoChangeViewControllerTypeRegion ? content : nil sign:self.type == UserInfoChangeViewControllerTypeSign ? content : nil success:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showSuccess:@"更新成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failed:^{
        [MBProgressHUD hideHUDForView:self.view];
        [MBProgressHUD showError:@"更新失败"];
    }];
    
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
