//
//  UserModel.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "UserModel.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ConstDefine.h"
#import "Session.h"
@implementation UserModel
+(void)UserModelWithEaseMobUserName:(NSString *)userName isUpdate:(BOOL)isupDate hanlde:(void (^)(UserModel *))hanlde{
    
    if (isupDate) {
        [UserModel deleteObjectsByCriteria:[NSString stringWithFormat:@"WHERE %@ = %@",USER_NAME_KEY,userName]];
    }
    
  __block  UserModel* userModel = [UserModel findFirstByCriteria:[NSString stringWithFormat:@"WHERE %@ = %@",USER_NAME_KEY,userName]];
    
    
    if (!userModel) {
        AVQuery* query = [AVQuery queryWithClassName:USER_CLASS_KEY];
        [query whereKey:USER_NAME_KEY equalTo:userName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            AVObject* obj = [objects firstObject];
            userModel = [[UserModel alloc] init];
            userModel.objectID = obj.objectId;
            userModel.userName = [obj objectForKey:USER_NAME_KEY];
            userModel.portrait = [obj objectForKey:USER_PORTRAIT_KEY];
            userModel.nickName = [obj objectForKey:USER_NICKNAME_KEY];
            userModel.region = [obj objectForKey:USER_REGION_KEY];
            userModel.gender = [obj objectForKey:USER_GENDER_KEY];
            userModel.sign = [obj objectForKey:USER_SIGN_KEY];
            userModel.address = [obj objectForKey:USER_ADDRESS_KEY];
            [userModel save];
            hanlde(userModel);
        }];
    }else{
        hanlde(userModel);
    }
    
    
}

+(void)updateForLocalHandle:(void (^)())handle{
    //更新 本地数据
    [UserModel UserModelWithEaseMobUserName:[Session sharedSession].currentUserModel.userName isUpdate:YES hanlde:^(UserModel *userModel) {
        [Session sharedSession].currentUserModel = userModel;
        handle();
    }];

}

-(NSString *)Pinyin{
    return [self transform:self.nickName];
}

+(void)saveUserForAutoLoginWithUserName:(NSString *)userName password:(NSString *)password{
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:USER_NAME_KEY];
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:USER_PASSWORD_KEY];
}

+(NSDictionary *)loadUserForAutoLogin{
    NSString* userName = [[NSUserDefaults standardUserDefaults] valueForKey:USER_NAME_KEY];
    NSString* password = [[NSUserDefaults standardUserDefaults] valueForKey:USER_PASSWORD_KEY];
    
    return @{USER_NAME_KEY : userName , USER_PASSWORD_KEY : password};
}

+(void)clearUserInfoForLocalAutoLogin{
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:USER_NAME_KEY];
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:USER_PASSWORD_KEY];
}
#pragma pravite method
- (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    
    NSString* str = [pinyin uppercaseString];
    
    
    
    return [str substringToIndex:1];
}
@end
