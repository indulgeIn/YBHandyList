//
//  YBHCollectionHeaderFooterProtocol.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBHCollectionHeaderFooterConfig;
@class YBHCollectionSection;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHCollectionHeaderFooterProtocol <NSObject>

@required

/**
 传递配置对象给 header/footer (根据配置对象拿到数据更新UI)
 
 @param config 配置对象
 */
- (void)ybhc_setHeaderFooterConfig:(id<YBHCollectionHeaderFooterConfig>)config;

/**
 获取 header/footer 的高度
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param section section
 @param sectionPack cell 所属 section 的配置，可能会有用
 @return 高度
 */
+ (CGSize)ybhc_sizeForHeaderFooterWithConfig:(id<YBHCollectionHeaderFooterConfig>)config reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section sectionPack:(YBHCollectionSection *)sectionPack;

@optional

/** 刷新 UICollectionView */
@property (nonatomic, copy) void(^ybhc_reloadCollectionView)(void);

@end

NS_ASSUME_NONNULL_END
