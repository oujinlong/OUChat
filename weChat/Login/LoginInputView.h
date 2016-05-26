//
//  LoginInputView.h
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginInputView : UIView
-(instancetype)initWithTitle:(NSString*)title placeHolder:(NSString*)placeHolder isPassword:(BOOL)isPassword;
/**
 *  获取输入的内容
 */
-(NSString*)getContentText;

/**
 *  手动修改 Textfield 内容
 *
 */
-(void)setText:(NSString*)text;
@end
