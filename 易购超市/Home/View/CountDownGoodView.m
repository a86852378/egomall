//
//  CountDownGoodView.m
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "CountDownGoodView.h"
#import "Good.h"

@interface CountDownGoodView () {
    UIImageView *goodImageView;
    UIButton *buyButton;
    UILabel *hourLabel;
    UILabel *colonLabel1;
    UILabel *minuteLabel;
    UILabel *colonLabel2;
    UILabel *secondLabel;
    dispatch_source_t _timer;
    
    NSDictionary *countDownGoodDic;
}

@end
@implementation CountDownGoodView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        Good *countDownGood = [[Good alloc] init];
        countDownGood.name = @"泰国金枕头榴莲6-7斤 (约1-2个) 水果";
        countDownGood.price = @"69.0";
        countDownGood.sales = @"62";
        countDownGood.image = @"https://img.alicdn.com/bao/uploaded/i1/TB1B98eJFXXXXbiXpXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg";
        countDownGood.type = @"水果";
        NSMutableArray *countDownGoodArr = [NSMutableArray array];
        [countDownGoodArr addObject:countDownGood];
        countDownGoodDic = [NSDictionary dictionary];
        countDownGoodDic = [countDownGoodArr objectAtIndex:0];
        
        goodImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, self.frame.size.width - 180, self.frame.size.height)];
        NSError *error;
        NSURL *url = [NSURL URLWithString:@"https://img.alicdn.com/bao/uploaded/i1/TB1B98eJFXXXXbiXpXXXXXXXXXX_!!0-item_pic.jpg_430x430q90.jpg"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        UIImage *goodImage = [UIImage imageWithData:data];
        goodImageView.image = goodImage;
        [self addSubview:goodImageView];
        
        buyButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 60, 40, 40)];
        [buyButton setImage:[UIImage imageNamed:@"抢"] forState:UIControlStateNormal];
        [buyButton addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buyButton];
        
        //倒计时器
        hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        hourLabel.layer.cornerRadius = 3;
        hourLabel.layer.masksToBounds = YES;
        hourLabel.backgroundColor = [UIColor redColor];
        hourLabel.textColor = [UIColor whiteColor];
        hourLabel.font = [UIFont systemFontOfSize:14];
        hourLabel.textAlignment = NSTextAlignmentCenter;
        colonLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 5, 20)];
        colonLabel1.text = @":";
        colonLabel1.textColor = [UIColor redColor];
        minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 20, 20, 20)];
        minuteLabel.layer.cornerRadius =3;
        minuteLabel.layer.masksToBounds = YES;
        minuteLabel.backgroundColor = [UIColor redColor];
        minuteLabel.textColor = [UIColor whiteColor];
        minuteLabel.font = [UIFont systemFontOfSize:14];
        minuteLabel.textAlignment = NSTextAlignmentCenter;
        colonLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(65, 20, 5, 20)];
        colonLabel2.text = @":";
        colonLabel2.textColor = [UIColor redColor];
        secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 20, 20, 20)];
        secondLabel.layer.cornerRadius =3;
        secondLabel.layer.masksToBounds = YES;
        secondLabel.backgroundColor = [UIColor redColor];
        secondLabel.textColor = [UIColor whiteColor];
        secondLabel.font = [UIFont systemFontOfSize:14];
        secondLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:hourLabel];
        [self addSubview:colonLabel1];
        [self addSubview:minuteLabel];
        [self addSubview:colonLabel2];
        [self addSubview:secondLabel];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        NSDate *endDate = [dateFormatter dateFromString:[self getdateStr]];
        NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate] + 24*3600)];
        NSDate *startDate = [NSDate date];
        NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
        
        if (_timer==nil) {
            __block int timeout = timeInterval; //倒计时时间
            
            if (timeout!=0) {
                dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                dispatch_source_set_event_handler(_timer, ^{
                    if(timeout<=0){ //倒计时结束，关闭
                        dispatch_source_cancel(_timer);
                        _timer = nil;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            hourLabel.text = @"00";
                            minuteLabel.text = @"00";
                            secondLabel.text = @"00";
                        });
                    }else{
                        int hours = (int)(timeout/3600);
                        int minute = (int)(timeout-hours*3600)/60;
                        int second = (int)timeout-hours*3600-minute*60;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (hours<10) {
                                hourLabel.text = [NSString stringWithFormat:@"0%d",hours];
                            }else{
                                hourLabel.text = [NSString stringWithFormat:@"%d",hours];
                            }
                            if (minute<10) {
                                minuteLabel.text = [NSString stringWithFormat:@"0%d",minute];
                            }else{
                                minuteLabel.text = [NSString stringWithFormat:@"%d",minute];
                            }
                            if (second<10) {
                                secondLabel.text = [NSString stringWithFormat:@"0%d",second];
                            }else{
                                secondLabel.text = [NSString stringWithFormat:@"%d",second];
                            }
                        });
                        timeout--;
                    }
                });
                dispatch_resume(_timer);
            }
        }

    }
    return self;
}

- (NSString *)getdateStr {
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatDay stringFromDate:now];
    return dateStr;
    
}

- (void)buyButtonAction {
    if(self.deleGate && [self.deleGate respondsToSelector:@selector(countDownClickActionAbout:)]){
        [self.deleGate countDownClickActionAbout:countDownGoodDic];
    }
}

@end
