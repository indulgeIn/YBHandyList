//
//  WellKnownSayingTwoCellModel.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBHandyList.h"

NS_ASSUME_NONNULL_BEGIN

@interface WellKnownSayingTwoCellModel : NSObject <YBHTableCellConfig>

@property (nonatomic, copy) NSString *showName;

@property (nonatomic, copy) NSString *showComment;

/// 点击刷新按钮的回调（此处用闭包，也可以用代理方式）
@property (nonatomic, copy) void(^clickRefreshButtonBlock)(void);

@end

NS_ASSUME_NONNULL_END
