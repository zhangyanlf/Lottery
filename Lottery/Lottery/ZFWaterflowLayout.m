//
//  ZFWaterflowLayout.m
//  Lottery
//
//  Created by 张彦林 on 2018/2/1.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZFWaterflowLayout.h"
#import "ZFShop.h"
//默认的行数
static const CGFloat ZFDefaultColumnCount = 3;
//每一列之间的间距
static const CGFloat ZFDefaultColumnMargin = 10;
//每一行之间的间距
static const CGFloat ZFDefaultRowMargin = 10;
//边缘间距
static const UIEdgeInsets ZFDefaultEdgeInsets = {10, 10, 10, 10};
@interface ZFWaterflowLayout ()

/**
 存放所有cell的布局属性
 */
@property (nonatomic,strong) NSMutableArray *attriArray;

/**
 存放左右列的最大高度
 */
@property (nonatomic,strong) NSMutableArray *columnHeights;
- (CGFloat) rowMargin;
- (CGFloat) columnMargin;
- (NSInteger) columnCount;
- (UIEdgeInsets)edgeInsets;
@end

@implementation ZFWaterflowLayout
#pragma 常见数据处理
- (CGFloat) rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMarginInWaterFlowerLayout:)]) {
        return [self.delegate rowMarginInWaterFlowerLayout:self];
    } else {
        return ZFDefaultRowMargin;
    }
}

- (CGFloat) columnMargin
{
    if ([self.delegate respondsToSelector:@selector(columnMarginInWaterFlowerLayout:)]) {
        return [self.delegate columnMarginInWaterFlowerLayout:self];
    } else {
        return ZFDefaultColumnMargin;
    }
}

- (NSInteger) columnCount
{
    if ([self.delegate respondsToSelector:@selector(columnCountInWaterFlowerLayout:)]) {
        return [self.delegate columnCountInWaterFlowerLayout:self];
    } else {
        return ZFDefaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsInWaterFlowerLayout:)]) {
        return [self.delegate edgeInsetsInWaterFlowerLayout:self];
    } else {
        return ZFDefaultEdgeInsets;
    }
}

#pragma mark - 懒加载
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
    
}

- (NSMutableArray *)attriArray {
    if (!_attriArray) {
        _attriArray = [NSMutableArray array];
    }
    return _attriArray;
    
}

/**
 初始化
 */
- (void)prepareLayout
{
    [super prepareLayout];
    //清楚之前的计算的所有高度
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    
    //清楚之前的布局属性
    [self.attriArray removeAllObjects];
    //开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //获取indexPath位置cell对应的布局属性
        UICollectionViewLayoutAttributes *attri = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attriArray addObject:attri];
    }
}

/**
 决定cell的排序
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"%s",__func__);
    
    
    return self.attriArray;
}

/**
 返回indexPath 位置 cell对应的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //创建布局属性
    UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //设置布局属性的frame
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
//    CGFloat h = 50 + arc4random_uniform(150);
    //ZFShop *shops = self.shops[indexPath.item];
    //CGFloat h = w * shops.h / shops.w;
    CGFloat h = [self.delegate waterflowLayout:self heightForItemAtIndexPath:indexPath.item itemWidth:w];
    
    //找出高度最小的那一行
    /*
    __block NSInteger destColumn = 0;
    __block CGFloat minColumnHeight = MAXFLOAT;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *columnHeightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat columnHeight = columnHeightNumber.doubleValue;
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = idx;
        }
    }];
     */
    NSInteger destColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        //取出第i列高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    
    CGFloat y= minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attri.frame = CGRectMake(x, y, w, h);
    //更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attri.frame));
    
    return attri;
}

- (CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        //取出第i列高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
            
        }
    }
    return CGSizeMake(0, maxColumnHeight + self.edgeInsets.bottom);
}



















@end
