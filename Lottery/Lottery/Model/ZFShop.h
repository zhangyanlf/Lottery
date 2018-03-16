//
//  ZFShop.h
//  Lottery
//
//  Created by 张彦林 on 2018/3/15.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFShop : NSObject
/**
 宽度
 */
@property (nonatomic,assign) CGFloat w;
/**
 高度
 */
@property (nonatomic,assign) CGFloat h;
/**
 图片地址
 */
@property (nonatomic,strong) NSString *img;
/**
 价格
 */
@property (nonatomic,strong) NSString *price;
@end
