//
//  YBHandyCollectionIMP.h
//  YBHandyList
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
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

@interface YBHandyCollectionIMP : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 代理 (提供 UICollectionView 常用代理方法转发) */
@property (nonatomic, weak) id<YBHandyCollectionIMPDelegate> delegate;

/** 是否激活 UICollectionViewFlowLayout 的布局属性，默认为 NO */
@property (nonatomic, assign) BOOL enabledFlowLayoutProperties;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YBHCollectionSection *> *sectionArray;

@end

NS_ASSUME_NONNULL_END
