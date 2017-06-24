//
//  Macro.h
//  易购超市
//
//  Created by vison on 2017/6/22.
//  Copyright © 2017年 vison. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

//pragma mark - SIZE
#pragma mark - SIZE
#define SCREEN_SIZE        [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH       [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT      [UIScreen mainScreen].bounds.size.height
#define HEIGHT_STATUSBAR   20.0f
#define HEIGHT_TABBAR      49.0f
#define HEIGHT_NAVBAR      44.0f

#define SizeScale (SCREEN_WIDTH != 414 ? 1 : 1.1)
#define kFont(value) [UIFont systemFontOfSize:value * SizeScale]


//#pragma mark - Alert提示宏定义
#pragma mark - Alert提示宏定义
#define Alert(_S_, ...) [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]


//#pragma mark - 获取图片资源
#pragma mark - 获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]];

#pragma mark - ThirdPart KEY
// Mob SMS
#define     MOB_SMS_APPKEY      @"1deb60f90e784"
#define     MOB_SMS_SECRET      @"eeded3755b84300342a1cb36c47543d1"
// SSKeychain
//#define     SSKeychainService   @"com.intre.soundNote"

#endif /* Macro_h */
