//
//  TestTableNibCellConfig.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHTableCellConfig.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TestTableNibCellDelegate;

/**
 为 TestTableNibCell 做的配置对象，此处用于拓展一个代理属性和一个标题，可以继承 YBHTableCellConfig 也可以直接实现 <YBHTableCellConfig> 协议。
 */
@interface TestTableNibCellConfig : YBHTableCellConfig

@property (nonatomic, weak) id<TestTableNibCellDelegate> delegate;

@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
