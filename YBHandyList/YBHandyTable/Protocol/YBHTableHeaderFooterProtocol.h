//
//  YBHTableHeaderFooterProtocol.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBHTableHeaderFooterConfig;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHTableHeaderFooterProtocol <NSObject>

@required

/**
 传递配置对象给 header/footer (根据配置对象拿到数据更新UI)
 
 @param config 配置对象
 */
- (void)ybht_setHeaderFooterConfig:(id<YBHTableHeaderFooterConfig>)config;

/**
 获取 header/footer 的高度
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param section section
 @return 高度
 */
+ (CGFloat)ybht_heightForHeaderFooterWithConfig:(id<YBHTableHeaderFooterConfig>)config reuseIdentifier:(NSString *)reuseIdentifier section:(NSInteger)section;

@optional

/**
 刷新 tableView
 */
@property (nonatomic, copy) void(^ybht_reloadTableView)(void);

@end

NS_ASSUME_NONNULL_END
