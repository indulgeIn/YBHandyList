//
//  UITableView+YBHandyList.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHandyTableIMP.h"
#import "YBHTCommonInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 ybht_tableIMP 属性是核心代理实现类，其它属性都是便捷配置 ybht_tableIMP 的语法糖
 */
@interface UITableView (YBHandyList)

/** 一个 section，cell 配置数组 */
@property (nonatomic, strong, readonly) NSMutableArray<id<YBHTableCellConfig>> *ybht_rowArray;
/** 一个 section，header 配置 */
@property (nonatomic, strong, nullable) id<YBHTableHeaderFooterConfig> ybht_header;
/** 一个 section，footer 配置 */
@property (nonatomic, strong, nullable) id<YBHTableHeaderFooterConfig> ybht_footer;

/** 多个 section */
@property (nonatomic, strong, readonly) NSMutableArray<YBHTableSection *> *ybht_sectionArray;

/** 公共信息对象，将会下发到 Cell/Header/Footer */
@property (nonatomic, strong) YBHTCommonInfo *ybht_commonInfo;

/** 代理实现者，将数组内容转换为列表代理方法的核心类
 （需要实现额外的 UITableView 代理方法，可以自定义继承 YBHandyTableIMP 的类并赋值该属性）*/
@property (nonatomic, strong) __kindof YBHandyTableIMP *ybht_tableIMP;

@end

NS_ASSUME_NONNULL_END
