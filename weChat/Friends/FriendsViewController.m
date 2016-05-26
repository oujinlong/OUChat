//
//  FriendsViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "FriendsViewController.h"
#import "SearchTopView.h"
#import "FriendsTableViewCell.h"
@interface FriendsViewController () <UITableViewDataSource,UITableViewDelegate>
/**
 *  第一个 section 的数据源
 */
@property (nonatomic, strong) NSArray* topDataSource;

@property (nonatomic, weak) UITableView* tableView;

/**
 *  拼音首字母数组
 */
@property (nonatomic, strong) NSMutableArray* pinyinArray;

@property (nonatomic, strong) NSMutableArray* userArray;
@end

static NSString* topTitleKey = @"title";
static NSString* topImageKey = @"image";
@implementation FriendsViewController
- (NSMutableArray *)pinyinArray
{
   
    if (!_pinyinArray) {
        _pinyinArray = [NSMutableArray array];
        [[Session sharedSession].buddyList enumerateObjectsUsingBlock:^(UserModel * _Nonnull userModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![_pinyinArray containsObject:userModel.Pinyin]) {
                [_pinyinArray addObject:userModel.Pinyin];
            }
            
        }];
    }
    
    
    
    return _pinyinArray;
}

- (NSMutableArray *)userArray
{
    if (!_userArray) {
        _userArray = [NSMutableArray new];
        
        for (NSString* pinyin in self.pinyinArray) {
            NSMutableArray* subArray = [NSMutableArray array];
            [[Session sharedSession].buddyList enumerateObjectsUsingBlock:^(UserModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.Pinyin isEqualToString:pinyin]) {
                    [subArray addObject:obj];
                }
            }];
            [_userArray addObject:subArray];
        }
        
    }
    return _userArray;
}



- (NSArray *)topDataSource
{
    if (!_topDataSource) {
        
        NSArray* titleArray = @[@"新的朋友",@"群聊",@"标签",@"公众号"];
        NSArray* imageArray = @[@"plugins_FriendNotify",@"add_friend_icon_addgroup",@"Contact_icon_ContactTag",@"add_friend_icon_offical"];
        
        _topDataSource = @[@{topTitleKey : titleArray[0] , topImageKey : imageArray[0]} ,
                           @{topTitleKey : titleArray[1] , topImageKey : imageArray[1]},
                           @{topTitleKey : titleArray[2] , topImageKey : imageArray[2]},
                           @{topTitleKey : titleArray[3] , topImageKey : imageArray[3]}];
    }
    return _topDataSource;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setupNav];
    
    [self setupMain];
    
    
}

#pragma mark 布局相关
-(void)setupNav{
    self.title = @"通讯录";
    
    [self setRightItmeWithImage:@"barbuttonicon_addfriends" target:self action:@selector(rightItemClick)];
}

-(void)setupMain{
    UITableView* tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    tableView.sectionIndexColor = [UIColor darkGrayColor];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    SearchTopView* searchView = [[SearchTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    tableView.tableHeaderView = searchView;
}

-(void)setupTopCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexPtath{
    UIImageView* imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:[self.topDataSource[indexPtath.row] valueForKey:topImageKey]];
    [cell.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(37, 37));
    }];
    
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(imageView);
    }];
    label.text = [self.topDataSource[indexPtath.row] valueForKey:topTitleKey];
}

#pragma mark button click
- (void)rightItemClick {
    LOG_FUN;
}

#pragma mark <UITableViewDataSource,UITableViewDelegate>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.pinyinArray.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else{
        return ((NSArray*)self.userArray[section - 1]).count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [self setupTopCell:cell indexPath:indexPath];
        return cell;

    }else{
        FriendsTableViewCell* cell = [FriendsTableViewCell cellWithTableView:tableView];
        
        cell.userModel = self.userArray[indexPath.section - 1][indexPath.row];
        
        return cell;

    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    return self.pinyinArray[section - 1];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 25;
    }
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.pinyinArray;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return;
    }
    UserModel* user = self.userArray[indexPath.section - 1][indexPath.row];
    
    EaseMessageViewController* vc = [[EaseMessageViewController alloc] initWithConversationChatter:user.userName conversationType:EMConversationTypeChat];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
