//
//  YBHTableCellConfig.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBHTableCellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 UITableView cell 配置协议
 */
@protocol YBHTableCellConfig <NSObject>

@required

/** cell 的类类型 */
@property (nonatomic, strong) Class<YBHTableCellProtocol> ybht_cellClass;

@optional

/** cell 对应的数据模型 */
@property (nonatomic, strong) id ybht_model;

/** cell 的复用标识 */
@property (nonatomic, copy, nullable) NSString *ybht_cellReuseIdentifier;

/** cell 的默认高度 (优先级低于 YBHTableCellProtocol 代理方法返回的高度) */
@property (nonatomic, copy) NSNumber *ybht_defaultHeight;

@end


/**
 配置默认实现类，一般业务就够用了
 */
@interface YBHTableCellConfig : NSObject <YBHTableCellConfig>

@end

NS_ASSUME_NONNULL_END
