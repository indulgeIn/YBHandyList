//
//  YBHTableCellProtocol.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBHTableCellConfig;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHTableCellProtocol <NSObject>

@required

/**
 传递配置对象给 header/footer (根据配置对象拿到数据更新UI)
 
 @param config 配置对象
 */
- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config;

@optional

/**
 获取 cell 的高度
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param indexPath indexPath
 @return 高度
 */
+ (CGFloat)ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

/** 刷新 UITableView */
@property (nonatomic, copy) void(^ybht_reloadTableView)(void);

@end

NS_ASSUME_NONNULL_END
