//
//  TestCollectionController.m
//  YBHandyTableViewDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "TestCollectionController.h"
#import "TestCollectionModel.h"
#import "TestCollectionNibCell.h"
#import "YBHandyList.h"

@interface TestCollectionController () <YBHandyCollectionIMPDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TestCollectionController

#pragma mark - life cycle

- (void)dealloc {
    NSLog(@"释放：%@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YBHandyCollection";
    [self.view addSubview:self.collectionView];
    
    [self loadData];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - private

- (void)loadData {
    
    // 🐶 用法和 UITableView 很像，这里就不过于具体了。
    
    // ① 模拟构建数据模型
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i < 40; ++i) {
        TestCollectionModel *model = [TestCollectionModel new];
        model.text = [NSString stringWithFormat:@"第%d个", i];
        [modelArray addObject:model];
    }
    
    // ② 构建配置对象
    
    NSMutableArray *configArray = [NSMutableArray array];
    for (TestCollectionModel *model in modelArray) {
        YBHCollectionCellConfig *config = [YBHCollectionCellConfig new];
        config.model = model;
        config.cellClass = TestCollectionNibCell.self;
        [configArray addObject:config];
    }
    
    YBHCollectionHeaderFooterConfig *headerConfig = [YBHCollectionHeaderFooterConfig new];
    headerConfig.defaultSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 44);
    headerConfig.headerFooterClass = UICollectionReusableView.self;
    
    // ③ 赋值并刷新
    
//    YBHCollectionSection *section = [YBHCollectionSection new];
//    section.minimumLineSpacing = 10;
//    section.minimumInteritemSpacing = 15;
//    section.inset = UIEdgeInsetsMake(10, 15, 15, 10);
//    section.header = headerConfig;
//    [section.rowArray addObjectsFromArray:configArray];
//    [self.collectionView.ybhc_sectionArray addObject:section];

    //使用语法糖
    self.collectionView.ybhc_minimumLineSpacing = 10;
    self.collectionView.ybhc_minimumInteritemSpacing = 15;
    self.collectionView.ybhc_inset = UIEdgeInsetsMake(10, 15, 10, 15);
    self.collectionView.ybhc_header = headerConfig;
    [self.collectionView.ybhc_rowArray addObjectsFromArray:configArray];
    
    [self.collectionView reloadData];
}

#pragma mark - <YBHandyCollectionIMPDelegate>

- (void)ybhc_IMP:(YBHandyCollectionIMP *)imp collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath config:(id<YBHCollectionCellConfig>)config {
    NSLog(@"点击了 cell : %@", config);
}

#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = UICollectionViewFlowLayout.new;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        //这个代理提供了常用的 UITableView 代理转发
        _collectionView.ybhc_collectionIMP.delegate = self;
        
//        layout.itemSize = CGSizeMake(60, 60);
//        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//        layout.minimumInteritemSpacing = 50;
//        layout.minimumLineSpacing = 50;
        //将该属性设置为 NO 来让 UICollectionViewFlowLayout 的布局属性有效。
//        _collectionView.ybhc_collectionIMP.enabledFlowLayoutProperties = YES;
    }
    return _collectionView;
}

@end
