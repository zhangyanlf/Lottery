//
//  ZFWaterflowLayout.m
//  Lottery
//
//  Created by 张彦林 on 2018/2/1.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ZFWaterflowLayout.h"
@interface ZFWaterflowLayout ()
@property (nonatomic,strong) NSMutableArray *attriArray;

@end

@implementation ZFWaterflowLayout
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
    //清楚之前的
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
    //设置布局属性的frame
    attri.frame = CGRectMake(arc4random_uniform(300), arc4random_uniform(300), arc4random_uniform(300), arc4random_uniform(300));
    return attri;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(0, 1000);
}



















@end
