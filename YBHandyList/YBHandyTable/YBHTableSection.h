//
//  YBHTableSection.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHTableHeaderFooterConfig.h"
#import "YBHTableCellConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBHTableSection : NSObject

/** UITableView 的 header 配置 */
@property (nonatomic, strong, nullable) id<YBHTableHeaderFooterConfig> header;

/** UITableView 的 footer 配置 */
@property (nonatomic, strong, nullable) id<YBHTableHeaderFooterConfig> footer;

/** UITableView 的 cell 配置数组 */
@property (nonatomic, strong, readonly) NSMutableArray<id<YBHTableCellConfig>> *rowArray;

@end

NS_ASSUME_NONNULL_END
