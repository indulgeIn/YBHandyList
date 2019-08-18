//
//  WellKnownSayingOneCellModel.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "WellKnownSayingOneCellModel.h"
#import "WellKnownSayingOneCell.h"

@implementation WellKnownSayingOneCellModel

#pragma mark - <YBHTableCellConfig>

- (Class<YBHTableCellProtocol>)ybht_cellClass {
    return WellKnownSayingOneCell.self;
}

@end
