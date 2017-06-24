//
//  AppDelegate.m
//  易购超市
//
//  Created by vison on 2017/4/17.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:3.0];
    
    [self configUI];
    
    [SMSSDK registerApp:MOB_SMS_APPKEY withSecret:MOB_SMS_SECRET];

    return YES;
}

- (void)configUI {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    if(isLoged){
        RootViewController *rootVC = [RootViewController shareRootViewController];
        [self.window setRootViewController:rootVC];
    }
    else{
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        [self.window setRootViewController:loginViewController];
    }
}


@end
