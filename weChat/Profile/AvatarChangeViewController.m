//
//  AvatarChangeViewController.m
//  weChat
//
//  Created by oujinlong on 16/5/18.
//  Copyright © 2016年 oujinlongb. All rights reserved.
//

#import "AvatarChangeViewController.h"
#import "UIImageView+WebCache.h"
@interface AvatarChangeViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, weak) UIImageView* imageView;
@end

@implementation AvatarChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人头像";
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupMain];
}

- (void)setupMain {
    [self setRightItmeWithImage:@"barbuttonicon_more" target:self action:@selector(rightClick)];
    
    
    UIImageView* imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0).offset(-30);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(300);
    }];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.userModel.portrait]];
   
}

#pragma mark buttonCLick
-(void)rightClick{
    LOG_FUN;
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController* pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        pick.allowsEditing = YES;
        pick.delegate = self;
        [self presentViewController:pick animated:YES completion:nil];
        
    }];
    
    UIAlertAction* album = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController* pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pick.allowsEditing = YES;
        pick.delegate = self;
        [self presentViewController:pick animated:YES completion:nil];

    }];
    
    UIAlertAction* save = [UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }];
    
    UIAlertAction* cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:takePhoto];
    [alert addAction:album];
    [alert addAction:save];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存结果"
                          
                                                    message:msg
                          
                                                   delegate:self
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
    
}
#pragma  mark UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage* image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.imageView setImage:image];
    }];
 
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HTTP sharedHTTP] uploadAvatarWithImage:image success:^{
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showSuccess:@"上传成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        } failed:^(EMError * error) {
            [MBProgressHUD hideHUDForView:self.view];
            [MBProgressHUD showError:@"上传失败"];
        }];
    });
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
