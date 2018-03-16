//
//  ViewController.m
//  Lottery
//
//  Created by 张彦林 on 2018/2/1.
//  Copyright © 2018年 zhangyanlf. All rights reserved.
//

#import "ViewController.h"
#import "ZFWaterflowLayout.h"
#import "ZFShop.h"
#import "ZFShopCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,ZFWaterflowLayoutDelegate>
/**
 数据源
 */
@property (nonatomic,strong) NSMutableArray *shops;

@property (nonatomic,strong)  UICollectionView *collectionView;

//@property (nonatomic,assign) ZFWaterflowLayout *layout;
@end

@implementation ViewController

- (NSMutableArray *)shops
{
    if (!_shops) {
        _shops =[NSMutableArray array];
    }
    return _shops;
}

static NSString *const collID = @"collID";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayout];
   
    [self setupRefresh];
    
    
    
}

- (void) setupRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewShops)];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreShops)];
     [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer.hidden = YES;
}

- (void) loadNewShops
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [ZFShop mj_objectArrayWithFilename:@"1.plist"];
        [self.shops removeAllObjects];
        [self.shops addObjectsFromArray:shops];
       
        
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
        self.collectionView.mj_footer.hidden = false;
        
        //self.layout.shops = self.shops;
        
    });
    
    
    
}

- (void) loadMoreShops
{
    [self.collectionView.mj_footer beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [ZFShop mj_objectArrayWithFilename:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        //self.layout.shops = self.shops;
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        
        
    });
    
    
    
}

- (void) setupLayout
{
    //创建布局
    ZFWaterflowLayout *layout = [[ZFWaterflowLayout alloc] init];
    //self.layout = layout;
    layout.delegate = self;
    
    //创建
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZFShopCell class]) bundle:nil] forCellWithReuseIdentifier:collID];
    collectionView.backgroundColor = [UIColor colorWithRed:155/255.0 green:185/255.0 blue:115/255.0 alpha:0.5];
    
    self.collectionView = collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.shops.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZFShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collID forIndexPath:indexPath];
    
    cell.shop = self.shops[indexPath.row];
    
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ZFWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(ZFWaterflowLayout *)waterflowLayout heightForItemAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth
{
    ZFShop *shop = self.shops[index];
    return itemWidth * shop.h / shop.w;
}

- (CGFloat)rowMarginInWaterFlowerLayout:(ZFWaterflowLayout *)waterFlowerLayout
{
    return 15;
}

- (CGFloat)columnMarginInWaterFlowerLayout:(ZFWaterflowLayout *)waterFlowerLayout
{
    return 15;
}



@end
