//
//  YBHTableHeaderFooterConfig.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHTableHeaderFooterConfig.h"

@implementation YBHTableHeaderFooterConfig

#pragma mark - <YBHTableHeaderFooterConfig>

- (Class<YBHTableHeaderFooterProtocol>)ybht_headerFooterClass {
    return self.headerFooterClass;
}

- (id)ybht_model {
    return self.model;
}

- (NSNumber *)ybht_defaultHeight {
    return self.defaultHeight;
}

- (NSString *)ybht_headerFooterReuseIdentifier {
    return self.headerFooterReuseIdentifier;
}

@end
