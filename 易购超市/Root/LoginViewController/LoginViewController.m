//
//  LoginViewController.m
//  易购超市
//
//  Created by vison on 2017/5/4.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "LoginViewController.h"
#import "RootViewController.h"
#import "RegisterViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    UIAlertController *alertController;
    UIImageView *headImageView;
    UITextField *phoneNumberTextField;
    UIView *phoneNumberLine;
    UITextField *passwordTextField;
    UIView *passwordLine;
    UIButton *loginButton;
    UIButton *registerButton;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    headImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 70) / 2, 80, 70, 70)];
    headImageView.layer.cornerRadius = 35;
    headImageView.layer.masksToBounds = YES;
    headImageView.image = [UIImage imageNamed:@"ego超市"];
    [self.view addSubview:headImageView];
    
    phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 200, SCREEN_WIDTH - 40, 20)];
    phoneNumberTextField.font = [UIFont systemFontOfSize:14];
    phoneNumberTextField.placeholder = @"手机号";
    phoneNumberTextField.tintColor = [UIColor orangeColor];
    phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneNumberTextField.returnKeyType = UIReturnKeyNext;
    phoneNumberTextField.delegate = self;
    [self.view addSubview:phoneNumberTextField];
    
    phoneNumberLine = [[UIView alloc] initWithFrame:CGRectMake(15, 225, SCREEN_WIDTH - 30, 0.5)];
    phoneNumberLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:phoneNumberLine];
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 270, SCREEN_WIDTH - 40, 20)];
    passwordTextField.font = [UIFont systemFontOfSize:14];
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.tintColor = [UIColor orangeColor];
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.returnKeyType = UIReturnKeyDone;
    passwordTextField.delegate = self;
    [self.view addSubview:passwordTextField];
    
    passwordLine = [[UIView alloc] initWithFrame:CGRectMake(15, 295, SCREEN_WIDTH - 30, 0.5)];
    passwordLine.backgroundColor = [UIColor redColor];
    [self.view addSubview:passwordLine];
    
    loginButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 350, SCREEN_WIDTH - 30, 30)];
    loginButton.layer.cornerRadius = 15;
    loginButton.backgroundColor = [UIColor orangeColor];
    [loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14];
    loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    registerButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 410, SCREEN_WIDTH - 30, 30)];
    registerButton.layer.cornerRadius = 15;
    registerButton.layer.masksToBounds = YES;
    [registerButton.layer setBorderWidth:0.3];
    registerButton.layer.borderColor = [UIColor redColor].CGColor;
    [registerButton setTitle:@"新用户注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    registerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    registerButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}

- (void)registerButtonAction {
    RegisterViewController *registerViewController = [[RegisterViewController alloc] init];
    registerViewController.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:registerViewController animated:YES completion:nil];
}

- (void)loginButtonAction {
    if(phoneNumberTextField.text.length != 11){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else if(passwordTextField.text.length <6){
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入至少6位密码!" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    else{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *urlStr = [NSString stringWithFormat:@"http://localhost/LoginAndRegister/admin.php?action=login&user_phone=%@&user_password=%@",phoneNumberTextField.text,passwordTextField.text];
        [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if([[responseObject valueForKey:@"flag"] isEqualToString:@"1"]){
                isLoged = 1;
                NSArray *arr = [responseObject valueForKey:@"data"];
                NSDictionary *dic = [arr objectAtIndex:0];
                User *user = [User shared];
                user.ID = [dic valueForKey:@"id"];
                user.name = [dic valueForKey:@"name"];
                user.phoneNumber = [dic valueForKey:@"phone"];
                user.password = [dic valueForKey:@"password"];
                alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功!" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    RootViewController *rootVC = [RootViewController shareRootViewController];
                    rootVC.view.backgroundColor = [UIColor whiteColor];
                    [self presentViewController:rootVC animated:YES completion:nil];
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
            }else{
                alertController = [UIAlertController alertControllerWithTitle:@"登录失败!" message:@"手机号或密码错误" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Error: %@",error);
        }];
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([textField isEqual:phoneNumberTextField]){
        if (range.location >= 11)
            return NO;
    }
    else if([textField isEqual:passwordTextField]){
        if (range.location >= 13)
            return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [phoneNumberTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}


@end
