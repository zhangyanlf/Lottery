# Lottery
瀑布流


# 自定义布局

``` iOS
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

```


# 自定义接口 -- 通过代理方法 实现 瀑布流布局 （高度/行数/间距等）

``` iOS
	
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

```
















