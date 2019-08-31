//
//  YBHandyTableIMP.h
//  YBHandyList
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHTableSection.h"
#import "YBHTCommonInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 代理实现类，可以直接抽出来作为 UITableView 的 delegate 和 dataSource，若想实现更多的代理方法，继承于该类在子类中拓展就行了。
 */
@interface YBHandyTableIMP : NSObject <UITableViewDataSource, UITableViewDelegate>

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YBHTableSection *> *sectionArray;

/** 公共信息对象，将会下发到 Cell/Header/Footer */
@property (nonatomic, strong) YBHTCommonInfo *commonInfo;

@end

NS_ASSUME_NONNULL_END
