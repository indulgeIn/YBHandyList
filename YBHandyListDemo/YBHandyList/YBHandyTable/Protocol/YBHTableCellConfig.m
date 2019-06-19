//
//  YBHTableCellConfig.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHTableCellConfig.h"

@implementation YBHTableCellConfig

#pragma mark - <YBHTableCellConfig>

- (Class<YBHTableCellProtocol>)ybht_cellClass {
    return self.cellClass;
}

- (id)ybht_model {
    return self.model;
}

- (NSNumber *)ybht_defaultHeight {
    return self.defaultHeight;
}

- (NSString *)ybht_cellReuseIdentifier {
    return self.cellReuseIdentifier;
}

@end
