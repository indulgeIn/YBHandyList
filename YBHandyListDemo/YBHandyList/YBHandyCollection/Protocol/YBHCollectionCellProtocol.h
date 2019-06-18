//
//  YBHCollectionCellProtocol.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YBHCollectionCellConfig;

NS_ASSUME_NONNULL_BEGIN

@protocol YBHCollectionCellProtocol <NSObject>

@required

/**
 传递配置对象给 header/footer (根据配置对象拿到数据更新UI)
 
 @param config 配置对象
 */
- (void)ybhc_setCellConfig:(id<YBHCollectionCellConfig>)config;

@optional

/**
 获取 cell 的大小
 
 @param config 配置对象
 @param reuseIdentifier 复用标识
 @param indexPath indexPath
 @return 大小
 */
+ (CGSize)ybhc_sizeForCellWithConfig:(id<YBHCollectionCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

/** 刷新 UICollectionView */
@property (nonatomic, copy) void(^ybhc_reloadCollectionView)(void);

@end

NS_ASSUME_NONNULL_END
