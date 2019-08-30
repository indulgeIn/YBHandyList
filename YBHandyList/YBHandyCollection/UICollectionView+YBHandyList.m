//
//  UICollectionView+YBHandyList.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
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

- (void)setYbhc_minimumLineSpacing:(CGFloat)ybhc_minimumLineSpacing {
    self.ybhc_firstSection.minimumLineSpacing = ybhc_minimumLineSpacing;
}
- (CGFloat)ybhc_minimumLineSpacing {
    return self.ybhc_firstSection.minimumLineSpacing;
}

- (void)setYbhc_minimumInteritemSpacing:(CGFloat)ybhc_minimumInteritemSpacing {
    self.ybhc_firstSection.minimumInteritemSpacing = ybhc_minimumInteritemSpacing;
}
- (CGFloat)ybhc_minimumInteritemSpacing {
    return self.ybhc_firstSection.minimumInteritemSpacing;
}

- (void)setYbhc_inset:(UIEdgeInsets)ybhc_inset {
    self.ybhc_firstSection.inset = ybhc_inset;
}
- (UIEdgeInsets)ybhc_inset {
    return self.ybhc_firstSection.inset;
}

- (YBHCollectionSection *)ybhc_firstSection {
    if (self.ybhc_sectionArray.count > 0) {
        return self.ybhc_sectionArray[0];
    }
    YBHCollectionSection *section = [YBHCollectionSection new];
    [self.ybhc_sectionArray addObject:section];
    return section;
}

- (void)setYbhc_commonInfo:(YBHCCommonInfo *)ybhc_commonInfo {
    self.ybhc_collectionIMP.commonInfo = ybhc_commonInfo;
}
- (YBHCCommonInfo *)ybhc_commonInfo {
    return self.ybhc_collectionIMP.commonInfo;
}

#pragma mark - getters & setters

static const void *YBHCSectionArrayKey = &YBHCSectionArrayKey;
- (void)setYbhc_sectionArray:(NSMutableArray<YBHCollectionSection *> * _Nonnull)ybhc_sectionArray {
    objc_setAssociatedObject(self, YBHCSectionArrayKey, ybhc_sectionArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<YBHCollectionSection *> *)ybhc_sectionArray {
    NSMutableArray *array = objc_getAssociatedObject(self, YBHCSectionArrayKey);
    if (!array) {
        array = [NSMutableArray array];
        self.ybhc_sectionArray = array;
        
        [self ybhc_collectionIMP]; //Just call.
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
    YBHandyCollectionIMP *imp = objc_getAssociatedObject(self, YBHCollectionIMPKey);
    if (!imp) {
        imp = [YBHandyCollectionIMP new];
        self.ybhc_collectionIMP = imp;
    }
    return imp;
}

@end
