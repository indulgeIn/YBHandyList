//
//  UICollectionView+YBHandyList.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "UICollectionView+YBHandyList.h"
#import <objc/runtime.h>

@implementation UICollectionView (YBHandyList)

#pragma mark - syntactic sugar

- (NSMutableArray<id<YBHCollectionCellConfig>> *)ybhc_rowArray {
    return self.ybhc_firstSection.rowArray;
}

- (void)setYbhc_header:(id<YBHCollectionHeaderFooterConfig>)ybhc_header {
    self.ybhc_firstSection.header = ybhc_header;
}
- (id<YBHCollectionHeaderFooterConfig>)ybhc_header {
    return self.ybhc_firstSection.header;
}

- (void)setYbhc_footer:(id<YBHCollectionHeaderFooterConfig>)ybhc_footer {
    self.ybhc_firstSection.footer = ybhc_footer;
}
- (id<YBHCollectionHeaderFooterConfig>)ybhc_footer {
    return self.ybhc_firstSection.footer;
}

- (YBHCollectionSection *)ybhc_firstSection {
    if (self.ybhc_sectionArray.count > 0) {
        return self.ybhc_sectionArray[0];
    }
    YBHCollectionSection *section = [YBHCollectionSection new];
    [self.ybhc_sectionArray addObject:section];
    return section;
}

#pragma mark - getters & setters

static const void *YBHCSectionArrayKey = &YBHCSectionArrayKey;
- (void)setYbhc_sectionArray:(NSMutableArray<YBHCollectionSection *> * _Nonnull)ybhc_sectionArray {
    objc_setAssociatedObject(self, YBHCSectionArrayKey, ybhc_sectionArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!self.ybhc_collectionIMP) {
        self.ybhc_collectionIMP = [YBHandyCollectionIMP new];
    }
}
- (NSMutableArray<YBHCollectionSection *> *)ybhc_sectionArray {
    NSMutableArray *array = objc_getAssociatedObject(self, YBHCSectionArrayKey);
    if (!array) {
        array = [NSMutableArray array];
        self.ybhc_sectionArray = array;
    }
    return array;
}

static const void *YBHCollectionIMPKey = &YBHCollectionIMPKey;
- (void)setYbhc_collectionIMP:(__kindof YBHandyCollectionIMP *)ybhc_collectionIMP {
    ybhc_collectionIMP.sectionArray = self.ybhc_sectionArray;
    self.delegate = ybhc_collectionIMP;
    self.dataSource = ybhc_collectionIMP;
    objc_setAssociatedObject(self, YBHCollectionIMPKey, ybhc_collectionIMP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YBHandyCollectionIMP *)ybhc_collectionIMP {
    return objc_getAssociatedObject(self, YBHCollectionIMPKey);
}

@end
