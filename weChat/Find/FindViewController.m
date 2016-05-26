//
//  FindViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "FindViewController.h"



@interface FindViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray* titleSource;
@property (nonatomic, strong) NSArray* imageSource;
@end

@implementation FindViewController
- (NSArray *)titleSource
{
    if (!_titleSource) {
        _titleSource = @[@[@"朋友圈"],@[@"扫一扫",@"摇一摇"],@[@"附近的人",@"漂流瓶"],@[@"购物",@"游戏"]];
    }
    return _titleSource;
}

- (NSArray *)imageSource
{
    if (!_imageSource) {
        _imageSource = @[@[@"ff_IconShowAlbum"],@[@"ff_IconQRCode",@"ff_IconShake"],@[@"ff_IconLocationService",@"ff_IconBottle"],@[@"CreditCard_ShoppingBag",@"MoreGame"]];

    }
    return _imageSource;
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"发现";
    
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

#pragma mark <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = 2;
    
    if (section == 0) {
        count = 1;
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
    
    UIImageView* imageView = [cell.contentView viewWithTag:1];
    imageView.image = [UIImage imageNamed:self.imageSource[indexPath.section][indexPath.row]];
    
    UILabel* label = [cell.contentView viewWithTag:2];
    label.text = self.titleSource[indexPath.section][indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
