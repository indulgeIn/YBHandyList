//
//  UICollectionView+YBHandyList.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHandyCollectionIMP.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (YBHandyList)

/** 一个 section，cell 配置数组 */
@property (nonatomic, strong, readonly) NSMutableArray<id<YBHCollectionCellConfig>> *ybhc_rowArray;

/** 一个 section，header 配置 */
@property (nonatomic, strong, nullable) id<YBHCollectionHeaderFooterConfig> ybhc_header;

/** 一个 section，footer 配置 */
@property (nonatomic, strong, nullable) id<YBHCollectionHeaderFooterConfig> ybhc_footer;

/** 多个 section */
@property (nonatomic, strong, readonly) NSMutableArray<YBHCollectionSection *> *ybhc_sectionArray;

/** 代理实现者（默认会有实现，可以自定义继承 YBHandyCollectionIMP 的类，主要场景是需要实现额外的 UITableView 的代理方法） */
@property (nonatomic, strong) __kindof YBHandyCollectionIMP *ybhc_collectionIMP;

@end

NS_ASSUME_NONNULL_END
