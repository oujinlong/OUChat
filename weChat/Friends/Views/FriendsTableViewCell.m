//
//  FriendsTableViewCell.m
//  weChat
//
//  Created by oujinlong on 16/5/22.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "FriendsTableViewCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
@interface FriendsTableViewCell ()
@property (nonatomic, weak) UIImageView* avatarImageView;
@property (nonatomic, weak) UILabel* nameLB;
@end
@implementation FriendsTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString* identifier = @"friends";
    FriendsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupMain];
        
    }
    return self;
}

-(void)setupMain{
    UIImageView* avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView = avatarImageView;
    [self.contentView addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    
    UILabel* nameLB = [[UILabel alloc] init];
    nameLB.font = [UIFont systemFontOfSize:17];
    nameLB.textColor = [UIColor blackColor];
    self.nameLB = nameLB;
    [self.contentView addSubview:nameLB];
    [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatarImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(avatarImageView);
    }];
    
}

-(void)setUserModel:(UserModel *)userModel{
    _userModel = userModel;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:userModel.portrait]];
    
    self.nameLB.text = userModel.nickName;
}
@end
