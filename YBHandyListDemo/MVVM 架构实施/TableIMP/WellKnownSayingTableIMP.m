//
//  WellKnownSayingTableIMP.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/8/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "WellKnownSayingTableIMP.h"

@implementation WellKnownSayingTableIMP

// 拓展一个代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 处理逻辑
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat scale = offsetY / UIScreen.mainScreen.bounds.size.height;
    // 回调出去
    if (self.endDragBlock) self.endDragBlock(scale);
}

@end
