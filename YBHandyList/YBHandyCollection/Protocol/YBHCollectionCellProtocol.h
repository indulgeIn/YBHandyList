//
//  YBHCollectionCellProtocol.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBHCCommonInfo.h"

@protocol YBHCollectionCellConfig;
@class YBHCollectionSection;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHCollectionCellProtocol <NSObject>

@optional

/**
 传递数据给 header/footer (根据配置对象拿到数据更新UI)
 
 @param config 配置对象
 @param indexPath indexPath
 @param commonInfo 公共信息
 */
- (void)ybhc_setCellConfig:(id<YBHCollectionCellConfig>)config indexPath:(NSIndexPath *)indexPath commonInfo:(YBHCCommonInfo *)commonInfo;
- (void)ybhc_setCellConfig:(id<YBHCollectionCellConfig>)config;

/**
 获取 cell 的大小
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param indexPath indexPath
 @param sectionPack cell 所属 section 的配置
 @param commonInfo 公共信息
 @return 大小
 */
+ (CGSize)ybhc_sizeForCellWithConfig:(id<YBHCollectionCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath sectionPack:(YBHCollectionSection *)sectionPack commonInfo:(YBHCCommonInfo *)commonInfo;
+ (CGSize)ybhc_sizeForCellWithConfig:(id<YBHCollectionCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath sectionPack:(YBHCollectionSection *)sectionPack;

/**
 当前 cell 被选中

 @param indexPath indexPath
 */
- (void)ybhc_didSelectedAtIndexPath:(NSIndexPath *)indexPath;

/** 刷新 UICollectionView */
@property (nonatomic, copy) void(^ybhc_reloadCollectionView)(void);

@end

NS_ASSUME_NONNULL_END
