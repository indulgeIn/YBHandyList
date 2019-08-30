//
//  UITableView+YBHandyList.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "UITableView+YBHandyList.h"
#import <objc/runtime.h>

@implementation UITableView (YBHandyList)

#pragma mark - syntactic sugar

- (NSMutableArray<id<YBHTableCellConfig>> *)ybht_rowArray {
    return self.ybht_firstSection.rowArray;
}

- (void)setYbht_header:(id<YBHTableHeaderFooterConfig>)ybht_header {
    self.ybht_firstSection.header = ybht_header;
}
- (id<YBHTableHeaderFooterConfig>)ybht_header {
    return self.ybht_firstSection.header;
}

- (void)setYbht_footer:(id<YBHTableHeaderFooterConfig>)ybht_footer {
    self.ybht_firstSection.footer = ybht_footer;
}
- (id<YBHTableHeaderFooterConfig>)ybht_footer {
    return self.ybht_firstSection.footer;
}

- (YBHTableSection *)ybht_firstSection {
    if (self.ybht_sectionArray.count > 0) {
        return self.ybht_sectionArray[0];
    }
    YBHTableSection *section = [YBHTableSection new];
    [self.ybht_sectionArray addObject:section];
    return section;
}

- (void)setYbht_commonInfo:(YBHTCommonInfo *)ybht_commonInfo {
    self.ybht_tableIMP.commonInfo = ybht_commonInfo;
}
- (YBHTCommonInfo *)ybht_commonInfo {
    return self.ybht_tableIMP.commonInfo;
}

#pragma mark - getters & setters

static const void *YBHTSectionArrayKey = &YBHTSectionArrayKey;
- (void)setYbht_sectionArray:(NSMutableArray<YBHTableSection *> * _Nonnull)ybht_sectionArray {
    objc_setAssociatedObject(self, YBHTSectionArrayKey, ybht_sectionArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableArray<YBHTableSection *> *)ybht_sectionArray {
    NSMutableArray *array = objc_getAssociatedObject(self, YBHTSectionArrayKey);
    if (!array) {
        array = [NSMutableArray array];
        self.ybht_sectionArray = array;
        
        [self ybht_tableIMP]; //Just call.
    }
    return array;
}

static const void *YBHTableIMPKey = &YBHTableIMPKey;
- (void)setYbht_tableIMP:(YBHandyTableIMP *)ybhl_tableIMP {
    ybhl_tableIMP.sectionArray = self.ybht_sectionArray;
    self.delegate = ybhl_tableIMP;
    self.dataSource = ybhl_tableIMP;
    objc_setAssociatedObject(self, YBHTableIMPKey, ybhl_tableIMP, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (YBHandyTableIMP *)ybht_tableIMP {
    YBHandyTableIMP *imp = objc_getAssociatedObject(self, YBHTableIMPKey);
    if (!imp) {
        imp = [YBHandyTableIMP new];
        self.ybht_tableIMP = imp;
    }
    return imp;
}

@end
