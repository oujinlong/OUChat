//
//  WeChatNavigationController.m
//  weChat
//
//  Created by oujinlong on 16/5/16.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "WeChatNavigationController.h"
#import "ConstDefine.h"
#import <objc/runtime.h>
@interface WeChatNavigationController ()

@end

@implementation WeChatNavigationController

+(instancetype)NavWithChildViewController:(UIViewController *)viewcontroller{
    
    WeChatNavigationController* nav = [[WeChatNavigationController alloc] initWithRootViewController:viewcontroller];
    
    nav.navigationBar.translucent = NO;
    
    nav.navigationBar.barStyle = UIBarStyleBlack;
    
    return nav;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];

    if (self.childViewControllers.count > 1) {
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"barbuttonicon_back"] forState:UIControlStateNormal];
//        [button setTitle:viewController.title forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 30, 28);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = item;
        [button addTarget: self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)pop:(UIButton*)button{
   WeChatNavigationController* vc = (WeChatNavigationController*)[self getCurrentViewControllerWithButton:button];
    
    [vc popViewControllerAnimated:YES];
}

-(UIViewController *)getCurrentViewControllerWithButton:(UIButton*)button{
    UIResponder *next = [button nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
