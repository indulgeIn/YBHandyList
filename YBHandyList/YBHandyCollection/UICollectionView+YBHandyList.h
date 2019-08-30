//
//  UICollectionView+YBHandyList.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHandyCollectionIMP.h"
#import "YBHCCommonInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 ybhc_collectionIMP 属性是核心代理实现类，其它属性都是便捷配置 ybhc_collectionIMP 的语法糖
 */
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

/** 公共信息对象，将会下发到 Cell/Header/Footer */
@property (nonatomic, strong) YBHCCommonInfo *ybhc_commonInfo;

/** 代理实现者，将数组内容转换为列表代理方法的核心类
 （需要实现额外的 UICollectionView 代理方法，可以自定义继承 YBHandyTableIMP 的类并赋值该属性）*/
@property (nonatomic, strong) __kindof YBHandyCollectionIMP *ybhc_collectionIMP;

@end

NS_ASSUME_NONNULL_END
