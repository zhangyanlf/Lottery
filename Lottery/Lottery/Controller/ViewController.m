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

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/**
 数据源
 */
@property (nonatomic,strong) NSMutableArray *shops;

@property (nonatomic,strong)  UICollectionView *collectionView;

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
        
    });
    
    
    
}

- (void) loadMoreShops
{
    [self.collectionView.mj_footer beginRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSArray *shops = [ZFShop mj_objectArrayWithFile:@"1.plist"];
        [self.shops addObjectsFromArray:shops];
        
        //刷新数据
        [self.collectionView reloadData];
        [self.collectionView.mj_footer endRefreshing];
        
    });
    
    
    
}

- (void) setupLayout
{
    //创建布局
    ZFWaterflowLayout *layout = [[ZFWaterflowLayout alloc] init];
    
    //创建
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    
    //注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZFShopCell class]) bundle:nil] forCellWithReuseIdentifier:collID];
    collectionView.backgroundColor = [UIColor yellowColor];
    
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


@end
