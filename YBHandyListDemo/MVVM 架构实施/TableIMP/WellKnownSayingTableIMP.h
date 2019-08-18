//
//  WellKnownSayingTableIMP.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/8/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHandyTableIMP.h"

NS_ASSUME_NONNULL_BEGIN

/**
 很多时候默认实现的 YBHandyTableIMP 就够用了，也不需要显式的去配置。
 
 当要实现 UITableView 额外的代理方法时就需要继承来拓展。
 
 看起来这样处理比较繁琐，实际上这个类也可以为承载 UITableView 的类 (UIViewController 或 UIVIew) 瘦身，将大量逻辑代码在这个类处理过后，仅仅返回一些必要的信息。
 */
@interface WellKnownSayingTableIMP : YBHandyTableIMP

/// 拖动结束回调（也可用代理方式）
@property (nonatomic, copy) void(^endDragBlock)(CGFloat scale);

@end

NS_ASSUME_NONNULL_END
