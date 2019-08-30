//
//  YBHTCommonInfo.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/8/30.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHTCommonInfo.h"

@implementation YBHTCommonInfo

- (instancetype)init {
    self = [super init];
    if (self) {
        CGSize size = UIScreen.mainScreen.bounds.size;
        _maxWidth = size.width;
        _maxHeight = size.height;
    }
    return self;
}

@end
