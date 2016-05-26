//
//  FriendsTableViewCell.h
//  weChat
//
//  Created by oujinlong on 16/5/22.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface FriendsTableViewCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView*)tableView;

@property (nonatomic, strong) UserModel* userModel;
@end
