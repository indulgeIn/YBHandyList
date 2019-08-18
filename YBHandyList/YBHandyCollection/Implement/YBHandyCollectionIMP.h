//
//  YBHandyCollectionIMP.h
//  YBHandyList
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHCollectionSection.h"

NS_ASSUME_NONNULL_BEGIN

@class YBHandyCollectionIMP;

@protocol YBHandyCollectionIMPDelegate <NSObject>
@optional

/**
 点击了某个 cell
 */
- (void)ybhc_IMP:(YBHandyCollectionIMP *)imp collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath config:(id<YBHCollectionCellConfig>)config;

/**
 滚动回调
 */
- (void)ybhc_IMP:(YBHandyCollectionIMP *)imp scrollViewDidScroll:(UIScrollView *)scrollView;

@end


/**
 代理实现类，可以直接抽出来作为 UICollectionView 的 delegate 和 dataSource，若想实现更多的代理方法，继承于该类在子类中拓展就行了。
 */
@interface YBHandyCollectionIMP : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 代理 (提供 UICollectionView 常用代理方法转发) */
@property (nonatomic, weak) id<YBHandyCollectionIMPDelegate> delegate;

/** 是否激活 UICollectionViewFlowLayout 的布局属性，默认为 NO */
@property (nonatomic, assign) BOOL enabledFlowLayoutProperties;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YBHCollectionSection *> *sectionArray;

@end

NS_ASSUME_NONNULL_END
