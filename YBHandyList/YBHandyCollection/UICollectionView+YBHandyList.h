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

/** 一个 section，cell 间距 */
@property (nonatomic, assign) CGFloat ybhc_minimumLineSpacing;
/** 一个 section，cell 间距 */
@property (nonatomic, assign) CGFloat ybhc_minimumInteritemSpacing;
/** 一个 section，外边距 */
@property (nonatomic, assign) UIEdgeInsets ybhc_inset;

/** 多个 section */
@property (nonatomic, strong, readonly) NSMutableArray<YBHCollectionSection *> *ybhc_sectionArray;

/** 代理实现者，将数组内容转换为列表代理方法的核心类
 （需要实现额外的 UICollectionView 代理方法，可以自定义继承 YBHandyTableIMP 的类并赋值该属性）*/
@property (nonatomic, strong) __kindof YBHandyCollectionIMP *ybhc_collectionIMP;

@end

NS_ASSUME_NONNULL_END
