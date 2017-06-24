//
//  RegisterViewController.m
//  易购超市
//
//  Created by vison on 2017/5/5.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>{
    UIAlertController *alertController;
    UITextField *userNameTextFiled;
    UIView *userNameLine;
    UITextField *phoneNumberTextFiled;
    UIView *phoneNumberLine;
    UITextField *verificationCodeTextFiled;
    UIButton *getVerificationCodeButton;
    UIView *verificationCodeLine;
    UITextField *passwordTextFiled;
    UIView *passwordLine;
    UITextField *confirmPasswordTextFiled;
    UIView *confirmPasswordLine;
    UIButton *confirmButton;
    UIButton *cancelButton;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    self.title = @"注册";
    
    userNameTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, 20)];
    userNameTextFiled.font = [UIFont systemFontOfSize:14];
    userNameTextFiled.placeholder = @"请输入用户名（3~8个字符）";
    userNameTextFiled.tintColor = [UIColor orangeColor];
    userNameTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameTextFiled.returnKeyType = UIReturnKeyNext;
    userNameTextFiled.delegate = self;
    [self.view addSubview:userNameTextFiled];
    
    userNameLine = [[UIView alloc] initWithFrame:CGRectMake(15, 125, SCREEN_WIDTH - 30, 0.5)];
    userNameLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:userNameLine];
    
    
    phoneNumberTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 140, SCREEN_WIDTH - 40, 20)];
    phoneNumberTextFiled.font = [UIFont systemFontOfSize:14];
    phoneNumberTextFiled.placeholder = @"请输入手机号码";
    phoneNumberTextFiled.tintColor = [UIColor orangeColor];
    phoneNumberTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumberTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberTextFiled.returnKeyType = UIReturnKeyNext;
    phoneNumberTextFiled.delegate = self;
    [self.view addSubview:phoneNumberTextFiled];
    
    phoneNumberLine = [[UIView alloc] initWithFrame:CGRectMake(15, 165, SCREEN_WIDTH - 30, 0.5)];
    phoneNumberLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:phoneNumberLine];
    
    
    verificationCodeTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 180, SCREEN_WIDTH - 140, 20)];
    verificationCodeTextFiled.font = [UIFont systemFontOfSize:14];
    verificationCodeTextFiled.placeholder = @"4位验证码";
    verificationCodeTextFiled.tintColor = [UIColor orangeColor];
    verificationCodeTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    verificationCodeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    verificationCodeTextFiled.returnKeyType = UIReturnKeyNext;
    verificationCodeTextFiled.delegate = self;
    [self.view addSubview:verificationCodeTextFiled];
    
    getVerificationCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 100, 175, 80, 25)];
    getVerificationCodeButton.layer.cornerRadius = 5;
    getVerificationCodeButton.backgroundColor = [UIColor orangeColor];
    [getVerificationCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getVerificationCodeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    getVerificationCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [getVerificationCodeButton addTarget:self action:@selector(getVerificationCodeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getVerificationCodeButton];
    
    verificationCodeLine = [[UIView alloc] initWithFrame:CGRectMake(15, 205, SCREEN_WIDTH - 30, 0.5)];
    verificationCodeLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:verificationCodeLine];
    
    
    passwordTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 220, SCREEN_WIDTH - 40, 20)];
    passwordTextFiled.font = [UIFont systemFontOfSize:14];
    passwordTextFiled.placeholder = @"设置密码（6-13位字母和数字组成）";
    passwordTextFiled.tintColor = [UIColor orangeColor];
    passwordTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextFiled.secureTextEntry = YES;
    passwordTextFiled.returnKeyType = UIReturnKeyNext;
    passwordTextFiled.delegate = self;
    [self.view addSubview:passwordTextFiled];
    
    passwordLine = [[UIView alloc] initWithFrame:CGRectMake(15, 245, SCREEN_WIDTH - 30, 0.5)];
    passwordLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:passwordLine];
    
    
    confirmPasswordTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 260, SCREEN_WIDTH - 40, 20)];
    confirmPasswordTextFiled.font = [UIFont systemFontOfSize:14];
    confirmPasswordTextFiled.placeholder = @"请再次输入密码";
    confirmPasswordTextFiled.tintColor = [UIColor orangeColor];
    confirmPasswordTextFiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    confirmPasswordTextFiled.secureTextEntry = YES;
    confirmPasswordTextFiled.returnKeyType = UIReturnKeyDone;
    confirmPasswordTextFiled.delegate = self;
    [self.view addSubview:confirmPasswordTextFiled];
    
    confirmPasswordLine = [[UIView alloc] initWithFrame:CGRectMake(15, 285, SCREEN_WIDTH - 30, 0.5)];
    confirmPasswordLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:confirmPasswordLine];
    
    
    confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 360, SCREEN_WIDTH - 30, 30)];
    confirmButton.layer.cornerRadius = 15;
    confirmButton.backgroundColor = [UIColor orangeColor];
    [confirmButton setTitle:@"确 认" forState:UIControlStateNormal];
    confirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
    confirmButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmButton];

    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 420, SCREEN_WIDTH - 30, 30)];
    cancelButton.layer.cornerRadius = 15;
    cancelButton.layer.masksToBounds = YES;
    [cancelButton.layer setBorderWidth:0.3];
    cancelButton.layer.borderColor = [UIColor redColor].CGColor;
    [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    cancelButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)getVerificationCodeButtonAction {
    [self hideKeyboard];
    if(phoneNumberTextFiled.text.length != 11){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取验证码成功!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phoneNumberTextFiled.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        }];
    }
}


- (void)confirmButtonAction {
    [self hideKeyboard];
    if(userNameTextFiled.text.length < 3){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入至少3个字符用户名!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(phoneNumberTextFiled.text.length != 11){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(verificationCodeTextFiled.text.length != 4){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的验证码!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else if(passwordTextFiled.text.length < 6){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入至少6位密码!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(confirmPasswordTextFiled.text.length < 6){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入确认密码!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(![passwordTextFiled.text isEqual:confirmPasswordTextFiled.text]){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次密码输入不一致!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else{
        [SMSSDK commitVerificationCode:verificationCodeTextFiled.text phoneNumber:phoneNumberTextFiled.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error)  {
            if(!error){
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                NSString *urlStr = [NSString stringWithFormat:@"http://localhost/LoginAndRegister/admin.php?action=register&user_name=%@&user_phone=%@&user_password=%@",userNameTextFiled.text,phoneNumberTextFiled.text,passwordTextFiled.text];
                [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if([[responseObject valueForKey:@"flag"] isEqualToString:@"1"]){
                        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功!" preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                [self dismissViewControllerAnimated:YES completion:nil];
                        }]];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }else{
                        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统错误，注册失败!" preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        }]];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"Error: %@",error);
                    alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接!" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }];
                
            }
            else{
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码错误!" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
    }
    
}

- (void)cancelButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)hideKeyboard {
    [userNameTextFiled resignFirstResponder];
    [phoneNumberTextFiled resignFirstResponder];
    [verificationCodeTextFiled resignFirstResponder];
    [passwordTextFiled resignFirstResponder];
    [confirmPasswordTextFiled resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if([textField isEqual:userNameTextFiled]){
        if(range.location >= 8){
            return NO;
        }
    }
    else if([textField isEqual:phoneNumberTextFiled]){
        if (range.location >= 11)
            return NO;
    }
    else if([textField isEqual:passwordTextFiled] | [textField isEqual:confirmPasswordTextFiled]){
        if (range.location >= 13)
            return NO;
    }
    else if([textField isEqual:verificationCodeTextFiled]){
        if (range.location >= 4)
            return NO;
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self hideKeyboard];
}


@end
