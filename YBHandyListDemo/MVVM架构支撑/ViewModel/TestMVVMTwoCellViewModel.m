//
//  TestMVVMTwoCellViewModel.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestMVVMTwoCellViewModel.h"
#import "TestMVVMTwoCell.h"

@implementation TestMVVMTwoCellViewModel

#pragma mark - <YBHTableCellConfig>

- (Class<YBHTableCellProtocol>)ybht_cellClass {
    return TestMVVMTwoCell.self;
}

@end
