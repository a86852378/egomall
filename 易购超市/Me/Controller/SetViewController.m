//
//  SetViewController.m
//  易购超市
//
//  Created by vison on 2017/5/14.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "SetViewController.h"

@interface SetViewController (){
    UIAlertController *alertController;
    UITextField *oldPasswordTextField;
    UIView *oldPasswordLineView;
    UITextField *newPasswordTextField;
    UIView *newPasswordLineView;
    UITextField *confirmPasswordTextFiled;
    UIView *confirmPasswordLineView;
    UIButton *confirmButton;
    UIButton *logoutButton;
}

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    __weak typeof(self.view) weakSelf = self.view;
    
    oldPasswordTextField = [[UITextField alloc] init];
    oldPasswordTextField.placeholder = @"请输入旧密码";
    oldPasswordTextField.font = [UIFont systemFontOfSize:15];
    oldPasswordTextField.secureTextEntry = YES;
    [self.view addSubview:oldPasswordTextField];
    [oldPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).with.offset(150);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf.mas_right).with.offset(-50);
        make.height.equalTo(@30);
    }];
    
    oldPasswordLineView = [[UIView alloc] init];
    oldPasswordLineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:oldPasswordLineView];
    [oldPasswordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPasswordTextField.mas_bottom);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf).with.offset(-50);
        make.height.equalTo(@0.3);
    }];
    
    newPasswordTextField = [[UITextField alloc] init];
    newPasswordTextField.placeholder = @"请输入新密码";
    newPasswordTextField.font = [UIFont systemFontOfSize:15];
    newPasswordTextField.secureTextEntry = YES;
    [self.view addSubview:newPasswordTextField];
    [newPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPasswordTextField.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf.mas_right).with.offset(-50);
        make.height.equalTo(@30);
    }];
    
    newPasswordLineView = [[UIView alloc] init];
    newPasswordLineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:newPasswordLineView];
    [newPasswordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newPasswordTextField.mas_bottom);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf).with.offset(-50);
        make.height.equalTo(@0.3);
    }];
    
    confirmPasswordTextFiled = [[UITextField alloc] init];
    confirmPasswordTextFiled.placeholder = @"请再次输入新密码";
    confirmPasswordTextFiled.font = [UIFont systemFontOfSize:15];
    confirmPasswordTextFiled.secureTextEntry = YES;
    [self.view addSubview:confirmPasswordTextFiled];
    [confirmPasswordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(newPasswordTextField.mas_bottom).with.offset(10);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf.mas_right).with.offset(-50);
        make.height.equalTo(@30);
    }];
    
    confirmPasswordLineView = [[UIView alloc] init];
    confirmPasswordLineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self.view addSubview:confirmPasswordLineView];
    [confirmPasswordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmPasswordTextFiled.mas_bottom);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf).with.offset(-50);
        make.height.equalTo(@0.3);
    }];
    
    confirmButton = [[UIButton alloc] init];
    [confirmButton setTitle:@"确 定" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.layer.cornerRadius = 3;
    confirmButton.backgroundColor = [UIColor orangeColor];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmPasswordTextFiled.mas_bottom).with.offset(40);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf.mas_right).with.offset(-50);
        make.height.equalTo(@30);
    }];

    
    logoutButton = [[UIButton alloc] init];
    [logoutButton setTitle:@"注 销 账 号" forState:UIControlStateNormal];
    logoutButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [logoutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    logoutButton.layer.cornerRadius = 3;
    logoutButton.backgroundColor = [UIColor orangeColor];
    [logoutButton addTarget:self action:@selector(logoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logoutButton];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confirmButton.mas_bottom).with.offset(50);
        make.left.equalTo(weakSelf).with.offset(50);
        make.right.equalTo(weakSelf.mas_right).with.offset(-50);
        make.height.equalTo(@30);
    }];
}

- (void)confirmButtonAction {
    if(oldPasswordTextField.text.length < 6){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确密码!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(newPasswordTextField.text.length < 6){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入至少6位新密码!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if(confirmPasswordTextFiled.text.length < 6){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入至少6位确认密码!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(![newPasswordTextField.text isEqualToString:confirmPasswordTextFiled.text]){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"新密码和确认密码不一致!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        User *user = [User shared];
        if([user.password isEqualToString:oldPasswordTextField.text]){
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            NSString *urlStr = [NSString stringWithFormat:@"http://localhost/LoginAndRegister/admin.php?action=update&user_phone=%@&user_newPassword=%@",user.phoneNumber,newPasswordTextField.text];
            [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改密码成功!" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    isLoged = 0;
                    [self.navigationController popViewControllerAnimated:YES];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"Error: %@",error);
            }];
        }
        else{
            alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码错误!" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }

}

- (void)logoutButtonAction {
    alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"注销成功!" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        User *user = [User shared];
        user.address = @"";
        isLoged = 0;
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
