//
//  YBHandyTableIMP.m
//  YBHandyList
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHandyTableIMP.h"

@implementation YBHandyTableIMP

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YBHTableSection *htSection = self.sectionArray[indexPath.section];
    id<YBHTableCellConfig> config = htSection.rowArray[indexPath.row];
    
    if ([config.ybht_cellClass respondsToSelector:@selector(ybht_heightForCellWithConfig:reuseIdentifier:indexPath:)]) {
        return [config.ybht_cellClass ybht_heightForCellWithConfig:config reuseIdentifier:[self reuseIdentifierForCellConfig:config] indexPath:indexPath];
    }
    if ([config respondsToSelector:@selector(ybht_defaultHeight)] && config.ybht_defaultHeight) {
        return config.ybht_defaultHeight.doubleValue;
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
    id<YBHTableCellConfig> cellConfig = htSection.rowArray[indexPath.row];
    
    Class cellClass = cellConfig.ybht_cellClass ?: UITableViewCell.self;
    NSString *identifier = [self reuseIdentifierForCellConfig:cellConfig];
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
        
        [tmpCell ybht_setCellConfig:cellConfig];
        
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

#pragma mark - private

- (NSString *)reuseIdentifierForCellConfig:(id<YBHTableCellConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybht_cellReuseIdentifier)]) {
        identifier = config.ybht_cellReuseIdentifier;
    }
    return identifier ?: NSStringFromClass(config.ybht_cellClass);
}

- (NSString *)reuseIdentifierForHeaderFooterConfig:(id<YBHTableHeaderFooterConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybht_headerFooterReuseIdentifier)]) {
        identifier = [config ybht_headerFooterReuseIdentifier];
    }
    return identifier ?: NSStringFromClass(config.ybht_headerFooterClass);
}

- (CGFloat)heightForHeaderFooterWithTableView:(UITableView *)tableView config:(id<YBHTableHeaderFooterConfig>)config section:(NSInteger)section {
    if (config && [config.ybht_headerFooterClass respondsToSelector:@selector(ybht_heightForHeaderFooterWithConfig:reuseIdentifier:section:)]) {
        return [config.ybht_headerFooterClass ybht_heightForHeaderFooterWithConfig:config reuseIdentifier:[self reuseIdentifierForHeaderFooterConfig:config] section:section];
    }
    if ([config respondsToSelector:@selector(ybht_defaultHeight)] && config.ybht_defaultHeight) {
        return config.ybht_defaultHeight.doubleValue;
    }
    return tableView.style == UITableViewStylePlain ? 0 : CGFLOAT_MIN;
}

- (__kindof UIView *)viewForHeaderFooterWithTableView:(UITableView *)tableView config:(id<YBHTableHeaderFooterConfig>)config section:(NSInteger)section {
    if (!config) return nil;
    
    Class headerFooterClass = config.ybht_headerFooterClass ?: UIView.self;
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
        
        [tmpView ybht_setHeaderFooterConfig:config];
        
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

@end
