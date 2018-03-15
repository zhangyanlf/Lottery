//
//  ZFWaterflowLayout.m
//  Lottery
//
//  Created by 张彦林 on 2018/2/1.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZFWaterflowLayout.h"
//默认的行数
static const CGFloat ZFDefaultColumnCount = 3;
//每一列之间的间距
static const CGFloat ZFDefaultColumnMargin = 10;
//每一行之间的间距
static const CGFloat ZFDefaultRowMargin = 10;
//边缘间距
static const UIEdgeInsets ZFDefaultEdgeInsets = {10,10,10,10};
@interface ZFWaterflowLayout ()

/**
 存放所有cell的布局属性
 */
@property (nonatomic,strong) NSMutableArray *attriArray;

/**
 存放左右列的最大高度
 */
@property (nonatomic,strong) NSMutableArray *columnHeights;

@end

@implementation ZFWaterflowLayout
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
    for (NSInteger i = 0; i < ZFDefaultColumnCount; i++) {
        [self.columnHeights addObject:@(ZFDefaultEdgeInsets.top)];
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
    CGFloat w = (collectionViewW - ZFDefaultEdgeInsets.left - ZFDefaultEdgeInsets.right - (ZFDefaultColumnCount - 1) * ZFDefaultColumnMargin) / ZFDefaultColumnCount;
    CGFloat h = 50 + arc4random_uniform(150);
    
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
    for (NSInteger i = 0; i < ZFDefaultColumnCount; i++) {
        //取出第i列高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    CGFloat x = ZFDefaultEdgeInsets.left + destColumn * (w + ZFDefaultColumnMargin);
    
    CGFloat y= minColumnHeight;
    if (y != ZFDefaultEdgeInsets.top) {
        y += ZFDefaultRowMargin;
    }
    attri.frame = CGRectMake(x, y, w, h);
    //更新最短那列的高度
    self.columnHeights[destColumn] = @(CGRectGetMaxY(attri.frame));
    
    return attri;
}

- (CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 0; i < ZFDefaultColumnCount; i++) {
        //取出第i列高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
            
        }
    }
    return CGSizeMake(0, maxColumnHeight + ZFDefaultEdgeInsets.bottom);
}



















@end
