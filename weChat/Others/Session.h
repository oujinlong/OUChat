//
//  Session.h
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface Session : NSObject
+(instancetype)sharedSession;
@property (nonatomic, strong) UserModel* currentUserModel;
@property (nonatomic, strong) NSMutableArray<UserModel*> * buddyList;
@end
