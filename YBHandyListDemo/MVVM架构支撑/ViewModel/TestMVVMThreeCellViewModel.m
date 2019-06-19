//
//  TestMVVMThreeCellViewModel.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestMVVMThreeCellViewModel.h"
#import "TestMVVMThreeCell.h"

@implementation TestMVVMThreeCellViewModel

#pragma mark - <YBHTableCellConfig>

- (Class<YBHTableCellProtocol>)ybht_cellClass {
    return TestMVVMThreeCell.self;
}

@end
