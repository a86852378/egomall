//
//  CategoryCollectionViewCell.m
//  易购超市
//
//  Created by vison on 2017/4/27.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "CategoryCollectionViewCell.h"


@interface CategoryCollectionViewCell() {
    UIImageView *imageView;
    UILabel *lable;
}
@end

@implementation CategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-36)/2, 9, 36, 36)];
        imageView.layer.cornerRadius = 18;
        imageView.layer.masksToBounds = YES;
        [self addSubview:imageView];

        lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.frame.size.width, 10)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        lable.font = [UIFont systemFontOfSize:10];
        [self addSubview:lable];
    }
    return self;
}

- (void)getImage:(NSString *)imageStr{
    imageView.image = [UIImage imageNamed:imageStr];
    lable.text = imageStr;
}

@end
