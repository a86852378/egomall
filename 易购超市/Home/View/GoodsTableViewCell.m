//
//  GoodsTableViewCell.m
//  易购超市
//
//  Created by vison on 2017/4/30.
//  Copyright © 2017年 vison. All rights reserved.
//

#import "GoodsTableViewCell.h"
#import "AFNetworking.h"

@interface GoodsTableViewCell() {
    UIImageView *imageView;
    UILabel *nameLabel;
    UILabel *priceLabel;
    UILabel *salesLabel;
    UIButton *buyButton;
    NSString *goodID;
}

@end

@implementation GoodsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 90, 90)];
        [self addSubview:imageView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, self.frame.size.width - 110 -10, 30)];
        nameLabel.textAlignment = NSTextAlignmentRight;
        nameLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:nameLabel];
        
        UILabel *preStr = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 120, 37, 60, 20)];
        preStr.text = @"惊爆价";
        preStr.textAlignment = NSTextAlignmentRight;
        preStr.textColor = [UIColor redColor];
        preStr.font = [UIFont systemFontOfSize:12];
        [self addSubview:preStr];
        
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 35, 50, 20)];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.textColor = [UIColor redColor];
        priceLabel.font = [UIFont systemFontOfSize:17];
        [self addSubview:priceLabel];
        
        salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 75, 50, 15)];
        salesLabel.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
        salesLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:salesLabel];
        
        buyButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width -34, 65, 24, 24)];
        buyButton.layer.cornerRadius = 12;
        buyButton.layer.masksToBounds = YES;
        UIImageView *buyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
        buyImageView.layer.cornerRadius = 12;
        buyImageView.layer.masksToBounds = YES;
        buyImageView.image = [UIImage imageNamed:@"加入购物车"];
        [buyButton addSubview:buyImageView];
        [buyButton addTarget:self action:@selector(buyButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buyButton];
    }
    return self;
}

- (void)buyButtonAction {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];     //网络请求数据
    [manager GET:[NSString stringWithFormat:@"http://localhost/ShoppingCart/admin.php?action=update&id=%@",goodID] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error: %@",error);
    }];

}

- (void)getImage:(NSString *)imageStr {
    NSError *error;
    NSURL *url = [NSURL URLWithString:imageStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    UIImage *image = [UIImage imageWithData:data];
    [imageView setImage:image];
}

- (void)getName:(NSString *)name {
    nameLabel.text = name;
}

- (void)getPrice:(NSString *)price {
    NSString *str = @"¥";
    priceLabel.text = [str stringByAppendingString:price];
}

- (void)getSales:(NSString *)sales {
    salesLabel.text = [sales stringByAppendingString:@" 销量"];
}

- (void)getID:(NSString *)ID {
    goodID = ID;
}

@end
