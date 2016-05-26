//
//  GenderChangeViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/20.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "GenderChangeViewController.h"

@interface GenderChangeViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, weak) UITableView* tableView;
@property (nonatomic, assign) BOOL isMan;
@end

@implementation GenderChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightItemWithTitle:@"保存" target:self action:@selector(saveClick)];
    
    [self setupMain];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    
}
- (void)setupMain {
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    self.isMan = [self.userModel.gender isEqualToString:@"男"];
    
    
}

- (void)saveClick {
    LOG_FUN;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HTTP sharedHTTP] updateNickName:nil address:nil gender:self.isMan ? @"男" : @"女" region:nil sign:nil success:^{
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

#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0) {
         cell.textLabel.textColor = self.isMan ? [WeChatStyle currentStyle].mainGreen : [UIColor grayColor];
        cell.textLabel.text = @"男";

    }else{
        cell.textLabel.textColor = !self.isMan ? [WeChatStyle currentStyle].mainGreen : [UIColor grayColor];
        cell.textLabel.text = @"女";
    }
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.isMan = indexPath.row == 0;
    
    [tableView reloadData];
   
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
