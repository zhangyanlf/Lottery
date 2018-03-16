//
//  ZFWaterflowLayout.h
//  Lottery
//
//  Created by 张彦林 on 2018/2/1.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZFWaterflowLayout;

@protocol ZFWaterflowLayoutDelegate<NSObject>

@required
- (CGFloat)waterflowLayout:(ZFWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth;

@optional
/**
 每一列的行数

 @param waterFlowerLayout waterFlowerLayout
 @return 返回行数  默认3行
 */
- (NSInteger) columnCountInWaterFlowerLayout:(ZFWaterflowLayout *)waterFlowerLayout;
/**
 每一列的间距

 @param waterFlowerLayout waterFlowerLayout
 @return 返回列间距 默认 10
 */
- (CGFloat) columnMarginInWaterFlowerLayout:(ZFWaterflowLayout *)waterFlowerLayout;
/**
 每一行的间距
 
 @param waterFlowerLayout waterFlowerLayout
 @return 返回行间距 默认 10
 */
- (CGFloat) rowMarginInWaterFlowerLayout:(ZFWaterflowLayout *)waterFlowerLayout;
/**
 边缘距离

 @param waterFlowerLayout waterFlowerLayout
 @return 返回边缘距离 默认为 {10,10,10,10}
 */
- (UIEdgeInsets) edgeInsetsInWaterFlowerLayout:(ZFWaterflowLayout *)waterFlowerLayout;
@end

@interface ZFWaterflowLayout : UICollectionViewLayout
//商品数组
//@property (nonatomic,strong) NSArray *shops;
/**
 代理方法
 */
@property (nonatomic,assign) id<ZFWaterflowLayoutDelegate>delegate;
@end
