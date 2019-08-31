//
//  YBHandyTableIMP.m
//  YBHandyList
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHandyTableIMP.h"

@implementation YBHandyTableIMP

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YBHTableSection *htSection = self.sectionArray[indexPath.section];
    id<YBHTableCellConfig> config = htSection.rowArray[indexPath.row];
    
    if ([config.ybht_cellClass respondsToSelector:@selector(ybht_heightForCellWithConfig:reuseIdentifier:indexPath:commonInfo:)]) {
        return [config.ybht_cellClass ybht_heightForCellWithConfig:config reuseIdentifier:[self reuseIdentifierForCellConfig:config] indexPath:indexPath commonInfo:self.commonInfo];
    }
    if ([config.ybht_cellClass respondsToSelector:@selector(ybht_heightForCellWithConfig:reuseIdentifier:indexPath:)]) {
        return [config.ybht_cellClass ybht_heightForCellWithConfig:config reuseIdentifier:[self reuseIdentifierForCellConfig:config] indexPath:indexPath];
    }
    if ([config respondsToSelector:@selector(ybht_defaultHeight)] && config.ybht_defaultHeight >= 0) {
        return config.ybht_defaultHeight;
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    YBHTableSection *htSection = self.sectionArray[section];
    id<YBHTableHeaderFooterConfig> config = htSection.header;
    
    return [self heightForHeaderFooterWithTableView:tableView config:config section:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    YBHTableSection *htSection = self.sectionArray[section];
    id<YBHTableHeaderFooterConfig> config = htSection.footer;
    
    return [self heightForHeaderFooterWithTableView:tableView config:config section:section];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YBHTableSection *htSection = self.sectionArray[section];
    id<YBHTableHeaderFooterConfig> config = htSection.header;
    
    return [self viewForHeaderFooterWithTableView:tableView config:config section:section];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YBHTableSection *htSection = self.sectionArray[section];
    id<YBHTableHeaderFooterConfig> config = htSection.footer;
    
    return [self viewForHeaderFooterWithTableView:tableView config:config section:section];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionArray[section].rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YBHTableSection *htSection = self.sectionArray[indexPath.section];
    id<YBHTableCellConfig> config = htSection.rowArray[indexPath.row];
    
    Class cellClass = [self validClassForCellConfig:config];
    NSString *identifier = [self reuseIdentifierForCellConfig:config];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        if (path) {
            [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellReuseIdentifier:identifier];
        } else {
            [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    
    if ([cell conformsToProtocol:@protocol(YBHTableCellProtocol)]) {
        UITableViewCell<YBHTableCellProtocol> *tmpCell = (UITableViewCell<YBHTableCellProtocol> *)cell;
        
        if ([tmpCell respondsToSelector:@selector(ybht_setCellConfig:indexPath:commonInfo:)]) {
            [tmpCell ybht_setCellConfig:config indexPath:indexPath commonInfo:self.commonInfo];
        }
        if ([tmpCell respondsToSelector:@selector(ybht_setCellConfig:)]) {
            [tmpCell ybht_setCellConfig:config];
        }
        if ([tmpCell respondsToSelector:@selector(setYbht_reloadTableView:)]) {
            __weak typeof(tableView) wTableView = tableView;
            [tmpCell setYbht_reloadTableView:^{
                __strong typeof(wTableView) tableView = wTableView;
                if (!tableView) return;
                [tableView reloadData];
            }];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(ybht_didSelectedAtIndexPath:)]) {
        [(id<YBHTableCellProtocol>)cell ybht_didSelectedAtIndexPath:indexPath];
    }
}

#pragma mark - private

- (Class)validClassForCellConfig:(id<YBHTableCellConfig>)config {
    return config.ybht_cellClass ?: UITableViewCell.self;
}

- (Class)validClassForHeaderFooterConfig:(id<YBHTableHeaderFooterConfig>)config {
    return config.ybht_headerFooterClass ?: UIView.self;
}

- (NSString *)reuseIdentifierForCellConfig:(id<YBHTableCellConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybht_cellReuseIdentifier)]) {
        identifier = config.ybht_cellReuseIdentifier;
    }
    return identifier ?: NSStringFromClass([self validClassForCellConfig:config]);
}

- (NSString *)reuseIdentifierForHeaderFooterConfig:(id<YBHTableHeaderFooterConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybht_headerFooterReuseIdentifier)]) {
        identifier = [config ybht_headerFooterReuseIdentifier];
    }
    return identifier ?: NSStringFromClass([self validClassForHeaderFooterConfig:config]);
}

- (CGFloat)heightForHeaderFooterWithTableView:(UITableView *)tableView config:(id<YBHTableHeaderFooterConfig>)config section:(NSInteger)section {
    if (config && [config.ybht_headerFooterClass respondsToSelector:@selector(ybht_heightForHeaderFooterWithConfig:reuseIdentifier:section:commonInfo:)]) {
        return [config.ybht_headerFooterClass ybht_heightForHeaderFooterWithConfig:config reuseIdentifier:[self reuseIdentifierForHeaderFooterConfig:config] section:section commonInfo:self.commonInfo];
    }
    if (config && [config.ybht_headerFooterClass respondsToSelector:@selector(ybht_heightForHeaderFooterWithConfig:reuseIdentifier:section:)]) {
        return [config.ybht_headerFooterClass ybht_heightForHeaderFooterWithConfig:config reuseIdentifier:[self reuseIdentifierForHeaderFooterConfig:config] section:section];
    }
    if ([config respondsToSelector:@selector(ybht_defaultHeight)] && config.ybht_defaultHeight >= 0) {
        return config.ybht_defaultHeight;
    }
    return tableView.style == UITableViewStylePlain ? 0 : CGFLOAT_MIN;
}

- (__kindof UIView *)viewForHeaderFooterWithTableView:(UITableView *)tableView config:(id<YBHTableHeaderFooterConfig>)config section:(NSInteger)section {
    if (!config) return nil;
    
    Class headerFooterClass = [self validClassForHeaderFooterConfig:config];
    NSString *identifier = [self reuseIdentifierForHeaderFooterConfig:config];
    
    UIView *view = nil;
    if ([headerFooterClass isSubclassOfClass:UITableViewHeaderFooterView.self]) {
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        if (!view) {
            NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(headerFooterClass) ofType:@"nib"];
            if (path) {
                [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(headerFooterClass) bundle:nil] forHeaderFooterViewReuseIdentifier:identifier];
            } else {
                [tableView registerClass:headerFooterClass forHeaderFooterViewReuseIdentifier:identifier];
            }
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
        }
    } else {
        view = [headerFooterClass new];
    }
    
    if ([view conformsToProtocol:@protocol(YBHTableHeaderFooterProtocol)]) {
        UIView<YBHTableHeaderFooterProtocol> *tmpView = (UIView<YBHTableHeaderFooterProtocol> *)view;
        
        if ([tmpView respondsToSelector:@selector(ybht_setHeaderFooterConfig:section:commonInfo:)]) {
            [tmpView ybht_setHeaderFooterConfig:config section:section commonInfo:self.commonInfo];
        }
        if ([tmpView respondsToSelector:@selector(ybht_setHeaderFooterConfig:)]) {
            [tmpView ybht_setHeaderFooterConfig:config];
        }
        if ([tmpView respondsToSelector:@selector(setYbht_reloadTableView:)]) {
            __weak typeof(tableView) wTableView = tableView;
            [tmpView setYbht_reloadTableView:^{
                __strong typeof(wTableView) sTableView = wTableView;
                if (sTableView) {
                    [sTableView reloadData];
                }
            }];
        }
    }
    
    return view;
}

#pragma mark - getter

- (NSMutableArray<YBHTableSection *> *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

- (YBHTCommonInfo *)commonInfo {
    if (!_commonInfo) {
        _commonInfo = [YBHTCommonInfo new];
    }
    return _commonInfo;
}

@end
