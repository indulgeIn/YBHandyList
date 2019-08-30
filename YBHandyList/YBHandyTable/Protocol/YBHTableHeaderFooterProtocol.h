//
//  YBHTableHeaderFooterProtocol.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBHTCommonInfo.h"

@protocol YBHTableHeaderFooterConfig;
@class YBHTableSection;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHTableHeaderFooterProtocol <NSObject>

@optional

/**
 传递数据给 header/footer (根据配置对象拿到数据更新UI)
 
 @param config 配置对象
 @param section section
 @param commonInfo 公共信息
 */
- (void)ybht_setHeaderFooterConfig:(id<YBHTableHeaderFooterConfig>)config section:(NSInteger)section commonInfo:(YBHTCommonInfo *)commonInfo;
- (void)ybht_setHeaderFooterConfig:(id<YBHTableHeaderFooterConfig>)config;

/**
 获取 header/footer 的高度
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param section section
 @param commonInfo 公共信息
 @return 高度
 */
+ (CGFloat)ybht_heightForHeaderFooterWithConfig:(id<YBHTableHeaderFooterConfig>)config reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section commonInfo:(YBHTCommonInfo *)commonInfo;
+ (CGFloat)ybht_heightForHeaderFooterWithConfig:(id<YBHTableHeaderFooterConfig>)config reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section;

/**
 刷新 tableView
 */
@property (nonatomic, copy) void(^ybht_reloadTableView)(void);

@end

NS_ASSUME_NONNULL_END
