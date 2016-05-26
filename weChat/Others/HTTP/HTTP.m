//
//  HTTP.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "HTTP.h"
#import "UserModel.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ConstDefine.h"
#import "Session.h"
#import "EMSDK.h"

@implementation HTTP
+(instancetype)sharedHTTP{
    static HTTP* instanceHttp = nil;
    static dispatch_once_t pre ;
    dispatch_once(&pre, ^{
        instanceHttp = [[HTTP alloc] init];
    });
    
    return instanceHttp;
}

-(void)registWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)())success failed:(void (^)(EMError *))failed{
    
   dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
      EMError* error = [[EMClient sharedClient] registerWithUsername:userName password:password];
       if (!error) {
           //储存数据模型同步
           //初始化一个数据模型给服务器
           AVObject* user = [AVObject objectWithClassName:USER_CLASS_KEY];
           [user setObject:userName forKey:USER_NAME_KEY];
           [user setObject:@"http://img5.duitang.com/uploads/item/201408/07/20140807105914_hShB5.png" forKey:USER_PORTRAIT_KEY];
           [user setObject:@"刚注册的小白" forKey:USER_NICKNAME_KEY];
           [user setObject:@"男" forKey:USER_GENDER_KEY];
           [user setObject:@"没有签名" forKey:USER_SIGN_KEY];
           [user saveInBackground];
           
           success();
       }else{
           failed(error);
       }
   });
}

-(void)loginWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)())success failed:(void (^)(EMError *))failed{
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        EMError* error = [[EMClient sharedClient] loginWithUsername:userName password:password];
        if (!error) {
            //同步数据模型
            Session* session = [Session sharedSession];
            [UserModel UserModelWithEaseMobUserName:userName isUpdate:NO hanlde:^(UserModel *userModel) {
                session.currentUserModel = userModel;
                
//                [[EMClient sharedClient].options setIsAutoLogin:NO];
                
                //同步好友
                [self fetchBuddyListSuccess:^{
                    [UserModel saveUserForAutoLoginWithUserName:userName password:password];
                    
                    success();
                } failed:^(EMError * error) {
                    failed(error);
                }];
                
               
            }];
            
            
        }else{
            failed(error);
        }
    });

}


-(void)uploadAvatarWithImage:(id)image success:(void (^)())success failed:(void (^)(EMError *))failed{
    
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    AVFile* avatarFile = [AVFile fileWithData:data];
    [avatarFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
           //更新 leanCloud 数据
            AVObject* avUser = [AVObject objectWithClassName:USER_CLASS_KEY objectId:[Session sharedSession].currentUserModel.objectID];
            [avUser setObject:avatarFile.url forKey:USER_PORTRAIT_KEY];
            [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (succeeded) {
                    //更新 本地数据
                    [UserModel updateForLocalHandle:^{
                         success();
                    }];
                }else {
                    failed(nil);
                }
               
            
            }];
            
           
        }else {
            failed(nil);
        }
    }];
}

-(void)updateNickName:(NSString *)nickName address:(NSString*)address gender:(NSString*)gender region:(NSString*)region sign:(NSString*)sign success:(void (^)())success failed:(void (^)())failed{
    
    //更新 LeanCloud 数据
     AVObject* avUser = [AVObject objectWithClassName:USER_CLASS_KEY objectId:[Session sharedSession].currentUserModel.objectID];
    if (nickName) {
        [avUser setObject:nickName forKey:USER_NICKNAME_KEY];
    }else if (address){
        [avUser setObject:address forKey:USER_ADDRESS_KEY];
    }else if (gender){
        [avUser setObject:gender forKey:USER_GENDER_KEY];
    }else if (region){
        [avUser setObject:region forKey:USER_REGION_KEY];
    }else if (sign){
        [avUser setObject:sign forKey:USER_SIGN_KEY];
    }
    [avUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //更新 本地数据
            [UserModel updateForLocalHandle:^{
                success();
            }];
        }else{
            failed();
        }
    }];
}

-(void)logoutSuccess:(void (^)())success failed:(void (^)(EMError* error))failed{

    
    //调用环信登出接口
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        EMError* error = [[EMClient sharedClient] logout:YES];
        if (!error) {
            // 清除 session
            Session* session = [Session sharedSession];
            session = nil;
            [UserModel clearUserInfoForLocalAutoLogin];
            success();
        }else {
            
            failed(error);
        }
    });
}

-(void)fetchBuddyListSuccess:(void (^)())success failed:(void (^)(EMError * error))failed{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        EMError* error = nil;
      NSArray* buddyList =  [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        if (!error) {
            
            [[Session sharedSession].buddyList removeAllObjects];
            
          __block  NSInteger index = 0 ;
            [buddyList enumerateObjectsUsingBlock:^(NSString*  _Nonnull userName, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [UserModel UserModelWithEaseMobUserName:userName isUpdate:NO hanlde:^(UserModel *userModel) {
                    [[Session sharedSession].buddyList addObject:userModel];
                    index ++ ;
                    if (index == buddyList.count ) {
                        success();
                    }
                }];
                
            }];
            
            
        }else {
            failed(error);
        }
    });
}

@end
