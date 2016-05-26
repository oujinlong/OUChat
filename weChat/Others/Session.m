//
//  Session.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "Session.h"

@implementation Session
+(instancetype)sharedSession{
    static Session* session = nil;
    static dispatch_once_t pre;
    dispatch_once(&pre, ^{
        session = [[Session alloc] init];
    });
    return session;
}

- (NSMutableArray *)buddyList
{
    if (!_buddyList) {
        _buddyList = [NSMutableArray new];
    }
    return _buddyList;
}


@end
