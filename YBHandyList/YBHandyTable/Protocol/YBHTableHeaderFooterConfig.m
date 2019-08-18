//
//  YBHTableHeaderFooterConfig.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHTableHeaderFooterConfig.h"

@implementation YBHTableHeaderFooterConfig

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _defaultHeight = -1;
    }
    return self;
}

#pragma mark - <YBHTableHeaderFooterConfig>

- (Class<YBHTableHeaderFooterProtocol>)ybht_headerFooterClass {
    return self.headerFooterClass;
}

- (id)ybht_model {
    return self.model;
}

- (CGFloat)ybht_defaultHeight {
    return self.defaultHeight;
}

- (NSString *)ybht_headerFooterReuseIdentifier {
    return self.headerFooterReuseIdentifier;
}

@end
