//
//  LoginInputView.m
//  weChat
//
//  Created by oujinlong on 16/5/17.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "LoginInputView.h"
#import "Masonry.h"
@interface LoginInputView ()
@property (nonatomic, weak) UITextField* textField;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, assign) BOOL isPassword;
@end
@implementation LoginInputView

-(instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder isPassword:(BOOL)isPassword{
    if (self = [super init]) {
        
        self.title = title;
        
        self.placeHolder = placeHolder;
        
        self.isPassword = isPassword;
        
        [self setupMain];
        
    }
    return self;
}


-(void)setupMain{
    
    self.backgroundColor = [UIColor clearColor];
    
    UILabel* label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
    }];
    label.text = self.title;
    
    UITextField* textField = [[UITextField alloc] init];
    self.textField = textField;
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = [UIColor blackColor];
    textField.secureTextEntry = self.isPassword;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.centerY.mas_equalTo(label);
        make.width.mas_equalTo(180);
    }];
    textField.placeholder = self.placeHolder;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
}
-(void)setText:(NSString *)text{
    self.textField.text = text;
}
-(NSString*)getContentText{
    
    return self.textField.text;

}

-(void)drawRect:(CGRect)rect{
    UIBezierPath* path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] setStroke];
    [path moveToPoint:CGPointMake(0, rect.size.height)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [path stroke];
}
@end
