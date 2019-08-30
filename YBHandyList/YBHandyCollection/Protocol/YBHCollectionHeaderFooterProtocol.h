//
//  YBHCollectionHeaderFooterProtocol.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBHCCommonInfo.h"

@protocol YBHCollectionHeaderFooterConfig;
@class YBHCollectionSection;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHCollectionHeaderFooterProtocol <NSObject>

@optional

/**
 传递数据给 header/footer (根据配置对象拿到数据更新UI)

 @param config 配置对象
 @param indexPath indexPath
 @param commonInfo 公共信息
 */
- (void)ybhc_setHeaderFooterConfig:(id<YBHCollectionHeaderFooterConfig>)config indexPath:(NSIndexPath *)indexPath commonInfo:(YBHCCommonInfo *)commonInfo;
- (void)ybhc_setHeaderFooterConfig:(id<YBHCollectionHeaderFooterConfig>)config;

/**
 获取 header/footer 的高度
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param section section
 @param sectionPack cell 所属 section 的配置
 @param commonInfo 公共信息
 @return 高度
 */
+ (CGSize)ybhc_sizeForHeaderFooterWithConfig:(id<YBHCollectionHeaderFooterConfig>)config reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section sectionPack:(YBHCollectionSection *)sectionPack commonInfo:(YBHCCommonInfo *)commonInfo;
+ (CGSize)ybhc_sizeForHeaderFooterWithConfig:(id<YBHCollectionHeaderFooterConfig>)config reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section sectionPack:(YBHCollectionSection *)sectionPack;

/** 刷新 UICollectionView */
@property (nonatomic, copy) void(^ybhc_reloadCollectionView)(void);

@end

NS_ASSUME_NONNULL_END
