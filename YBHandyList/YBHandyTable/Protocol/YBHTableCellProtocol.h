//
//  YBHTableCellProtocol.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBHTCommonInfo.h"

@protocol YBHTableCellConfig;
@class YBHTableSection;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHTableCellProtocol <NSObject>

@optional

/**
 传递数据给 cell (根据配置对象拿到数据更新UI)
 
 @param config 配置对象
 @param indexPath indexPath
 @param commonInfo 公共信息
 */
- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config indexPath:(NSIndexPath *)indexPath commonInfo:(YBHTCommonInfo *)commonInfo;
- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config;

/**
 获取 cell 的高度
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param indexPath indexPath
 @param commonInfo 公共信息
 @return 高度
 */
+ (CGFloat)ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath commonInfo:(YBHTCommonInfo *)commonInfo;
+ (CGFloat)ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

/**
 当前 cell 被选中
 
 @param indexPath indexPath
 */
- (void)ybht_didSelectedAtIndexPath:(NSIndexPath *)indexPath;

/** 刷新 UITableView */
@property (nonatomic, copy) void(^ybht_reloadTableView)(void);

@end

NS_ASSUME_NONNULL_END
