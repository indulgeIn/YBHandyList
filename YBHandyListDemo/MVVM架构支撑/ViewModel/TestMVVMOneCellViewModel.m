//
//  TestMVVMOneCellViewModel.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestMVVMOneCellViewModel.h"
#import "TestMVVMOneCell.h"

@implementation TestMVVMOneCellViewModel

#pragma mark - <YBHTableCellConfig>

- (Class<YBHTableCellProtocol>)ybht_cellClass {
    return TestMVVMOneCell.self;
}

@end
