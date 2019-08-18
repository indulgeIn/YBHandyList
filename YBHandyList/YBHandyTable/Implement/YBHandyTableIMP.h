//
//  YBHandyTableIMP.h
//  YBHandyList
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHTableSection.h"

NS_ASSUME_NONNULL_BEGIN

@class YBHandyTableIMP;

@protocol YBHandyTableIMPDelegate <NSObject>
@optional

/**
 点击了某个 cell
 */
- (void)ybht_IMP:(YBHandyTableIMP *)imp tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath config:(id<YBHTableCellConfig>)config;

/**
 滚动回调
 */
- (void)ybht_IMP:(YBHandyTableIMP *)imp scrollViewDidScroll:(UIScrollView *)scrollView;

@end


/**
 代理实现类，可以直接抽出来作为 UITableView 的 delegate 和 dataSource，若想实现更多的代理方法，继承于该类在子类中拓展就行了。
 */
@interface YBHandyTableIMP : NSObject <UITableViewDataSource, UITableViewDelegate>

/** 代理 (提供 UITableView 常用代理方法转发) */
@property (nonatomic, weak) id<YBHandyTableIMPDelegate> delegate;

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YBHTableSection *> *sectionArray;

@end

NS_ASSUME_NONNULL_END
