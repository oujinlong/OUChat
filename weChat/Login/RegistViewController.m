//
//  RegistViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITextField* userNameTF;
@property (nonatomic, weak) UITextField* passwordTF;
@end

@implementation RegistViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.userNameTF becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupMain];
}
-(void)setupNav{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"barbuttonicon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(closeClick)];
    self.navigationItem.leftBarButtonItem = item;
    
    self.title = @"注册新用户";
    
}


- (void)setupMain {
    
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    UIView* bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40)];
    tableView.tableFooterView = bottomView;
    
    UIButton* registButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registButton setTitle:@"注 册" forState:UIControlStateNormal];
    [registButton setBackgroundColor:[WeChatStyle currentStyle].mainGreen];
    [registButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.5];
    [bottomView addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 40);
    }];
    registButton.layer.cornerRadius = 8;
    registButton.layer.masksToBounds = YES;
    [registButton addTarget:self action:@selector(registClick) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupCellWithCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPath{
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    
    UITextField* textField = [[UITextField alloc] init];
    textField.font = label.font;
    textField.textColor = label.textColor;
    [cell.contentView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(90);
        make.centerY.mas_equalTo(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width - 100);
    }];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    if (indexPath.section == 0) {
        self.userNameTF = textField;
        label.text = @"用户名";
        textField.secureTextEntry = NO;
    }else{
        self.passwordTF = textField;
        label.text = @"密码";
        textField.secureTextEntry = YES;
    }
    
    
}

#pragma mark button click
-(void)closeClick{
    LOG_FUN;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)registClick{
    LOG_FUN;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (self.userNameTF.text.length && self.passwordTF.text.length) {
        [[HTTP sharedHTTP] registWithUserName:self.userNameTF.text password:self.passwordTF.text success:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showSuccess:@"注册成功" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            });
        } failed:^(EMError* error){
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showSuccess:error.errorDescription toView:self.view];
            });
        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"用户名和密码不能为空" toView:self.view];
        });
    
    }
    
        
}
#pragma mark <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
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
        [self setupCellWithCell:cell indexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
        return 30;
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
