//
//  WellKnownSayingTwoCellModel.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "WellKnownSayingTwoCellModel.h"
#import "WellKnownSayingTwoCell.h"

@implementation WellKnownSayingTwoCellModel

#pragma mark - <YBHTableCellConfig>

- (Class<YBHTableCellProtocol>)ybht_cellClass {
    return WellKnownSayingTwoCell.self;
}

@end
