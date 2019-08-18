//
//  YBHCollectionSection.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHCollectionSection.h"

@interface YBHCollectionSection ()
@property (nonatomic, strong) NSMutableArray<id<YBHCollectionCellConfig>> *rowArray;
@end

@implementation YBHCollectionSection

- (NSMutableArray<id<YBHCollectionCellConfig>> *)rowArray {
    if (!_rowArray) {
        _rowArray = [NSMutableArray array];
    }
    return _rowArray;
}

@end
