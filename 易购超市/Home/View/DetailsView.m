//
//  DetailsView.m
//  易购超市
//
//  Created by vison on 2017/5/3.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "DetailsView.h"

@interface DetailsView(){
    UIImageView *imageView;
    UIView *lineView;
    UILabel *nameLabel;
    UILabel *priceLabel;
    UILabel *salesLabel;
    UILabel *freeLabel;
    UILabel *yigouLabel;
    UIView *bottomLineView;
}

@end

@implementation DetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];
        [self addSubview:imageView];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, self.frame.size.width, 2)];
        lineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self addSubview:lineView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, self.frame.size.width - 20, 40)];
        [self addSubview:nameLabel];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 340, 100, 20)];
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:priceLabel];
        
        freeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 360, 60, 30)];
        freeLabel.font = [UIFont systemFontOfSize:10];
        freeLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        freeLabel.text = @"免配送费";
        [self addSubview:freeLabel];
        
        salesLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 60) / 2, 360, 60, 30)];
        salesLabel.font = [UIFont systemFontOfSize:10];
        salesLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        [self addSubview:salesLabel];
        
        yigouLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 70, 360, 60, 30)];
        yigouLabel.font = [UIFont systemFontOfSize:10];
        yigouLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        yigouLabel.textAlignment = NSTextAlignmentRight;
        yigouLabel.text = @"易购超市";
        [self addSubview:yigouLabel];
        
        bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 390, self.frame.size.width, 5)];
        bottomLineView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
        [self addSubview:bottomLineView];
    }
    return self;
}

- (void)transferDataWith:(NSDictionary *)dataDic {
    NSError *error;
    NSURL *url = [NSURL URLWithString:[dataDic valueForKey:@"image"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    UIImage *image = [UIImage imageWithData:data];
    imageView.image = image;
    
    nameLabel.text = [dataDic valueForKey:@"name"];
    priceLabel.text = [NSString stringWithFormat:@"¥%@",[dataDic valueForKey:@"price"]];
    salesLabel.text = [NSString stringWithFormat:@"销量 %@ 笔",[dataDic valueForKey:@"sales"]];
    
}


@end
