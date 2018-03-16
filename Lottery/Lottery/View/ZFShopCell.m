//
//  ZFShopCell.m
//  Lottery
//
//  Created by 张彦林 on 2018/3/15.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZFShopCell.h"
#import "ZFShop.h"
#import <UIImageView+WebCache.h>
@interface ZFShopCell ()

/**
 图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
/**
 价格
 */
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;

@end
@implementation ZFShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShop:(ZFShop *)shop
{
    //1.图片
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",shop.img]] placeholderImage:[UIImage imageNamed:@"wx"]];
    
    
    //2.价格
    self.shopLabel.text = shop.price;
    
}



@end
