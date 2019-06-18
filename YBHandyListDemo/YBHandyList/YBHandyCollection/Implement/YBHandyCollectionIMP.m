//
//  YBHandyCollectionIMP.m
//  YBHandyList
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHandyCollectionIMP.h"

@implementation YBHandyCollectionIMP {
    NSMutableSet *_reuseCellSet;
    NSMutableSet *_reuseHeaderSet;
    NSMutableSet *_reuseFooterSet;
}

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _reuseCellSet = [NSMutableSet set];
        _reuseHeaderSet = [NSMutableSet set];
        _reuseFooterSet = [NSMutableSet set];
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sectionArray[section].rowArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YBHCollectionSection *hcSection = self.sectionArray[indexPath.section];
    id<YBHCollectionCellConfig> cellConfig = hcSection.rowArray[indexPath.row];

    Class cellClass = cellConfig.ybhc_cellClass ?: UICollectionViewCell.self;
    NSString *identifier = [self reuseIdentifierForCellConfig:cellConfig];
    
    if (![_reuseCellSet containsObject:identifier]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cellClass) ofType:@"nib"];
        if (path) {
            [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cellClass) bundle:nil] forCellWithReuseIdentifier:identifier];
        } else {
            [collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
        }
        [_reuseCellSet addObject:identifier];
    }
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

    if ([cell conformsToProtocol:@protocol(YBHCollectionCellProtocol)]) {
        UICollectionViewCell<YBHCollectionCellProtocol> *tmpCell = (UICollectionViewCell<YBHCollectionCellProtocol> *)cell;

        [tmpCell ybhc_setCellConfig:cellConfig];

        if ([tmpCell respondsToSelector:@selector(setYbhc_reloadCollectionView:)]) {
            __weak typeof(collectionView) wCollectionView = collectionView;
            [tmpCell setYbhc_reloadCollectionView:^{
                __strong typeof(wCollectionView) collectionView = wCollectionView;
                if (!collectionView) return;
                [collectionView reloadData];
            }];
        }
    }

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YBHCollectionSection *htSection = self.sectionArray[indexPath.section];
    
    id<YBHCollectionHeaderFooterConfig> config;
    NSMutableSet *reuseSet;
    if (kind == UICollectionElementKindSectionHeader) {
        config = htSection.header;
        reuseSet = _reuseHeaderSet;
    } else if (kind == UICollectionElementKindSectionFooter) {
        config = htSection.footer;
        reuseSet = _reuseFooterSet;
    } else {
        return nil;
    }
    
    Class cls = config.ybhc_headerFooterClass ?: UICollectionReusableView.self;
    NSString *identifier = [self reuseIdentifierForHeaderFooterConfig:config];
    
    if (![reuseSet containsObject:identifier]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(cls) ofType:@"nib"];
        if (path) {
            [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
        } else {
            [collectionView registerClass:cls forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
        }
        [reuseSet addObject:identifier];
    }
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    
    if ([view conformsToProtocol:@protocol(YBHCollectionHeaderFooterProtocol)]) {
        UICollectionReusableView<YBHCollectionHeaderFooterProtocol> *tmpView = (UICollectionReusableView<YBHCollectionHeaderFooterProtocol> *)view;
        
        [tmpView ybhc_setHeaderFooterConfig:config];
        
        if ([tmpView respondsToSelector:@selector(setYbhc_reloadCollectionView:)]) {
            __weak typeof(collectionView) wCollectionView = collectionView;
            [tmpView setYbhc_reloadCollectionView:^{
                __strong typeof(wCollectionView) collectionView = wCollectionView;
                if (!collectionView) return;
                [collectionView reloadData];
            }];
        }
    }
    
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    YBHCollectionSection *htSection = self.sectionArray[indexPath.section];
    id<YBHCollectionCellConfig> config = htSection.rowArray[indexPath.row];
    
    if ([config.ybhc_cellClass respondsToSelector:@selector(ybhc_sizeForCellWithConfig:reuseIdentifier:indexPath:)]) {
        return [config.ybhc_cellClass ybhc_sizeForCellWithConfig:config reuseIdentifier:[self reuseIdentifierForCellConfig:config] indexPath:indexPath];
    }
    if ([config respondsToSelector:@selector(ybhc_defaultSize)] && !CGSizeEqualToSize(config.ybhc_defaultSize, CGSizeZero)) {
        return config.ybhc_defaultSize;
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    YBHCollectionSection *htSection = self.sectionArray[section];
    id<YBHCollectionHeaderFooterConfig> config = htSection.header;
    
    return [self sizeForHeaderFooterWithConfig:config section:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    YBHCollectionSection *htSection = self.sectionArray[section];
    id<YBHCollectionHeaderFooterConfig> config = htSection.header;
    
    return [self sizeForHeaderFooterWithConfig:config section:section];
}

#pragma mark - private

- (NSString *)reuseIdentifierForCellConfig:(id<YBHCollectionCellConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybhc_cellReuseIdentifier)]) {
        identifier = config.ybhc_cellReuseIdentifier;
    }
    return identifier ?: NSStringFromClass(config.ybhc_cellClass);
}

- (NSString *)reuseIdentifierForHeaderFooterConfig:(id<YBHCollectionHeaderFooterConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybhc_headerFooterReuseIdentifier)]) {
        identifier = [config ybhc_headerFooterReuseIdentifier];
    }
    return identifier ?: NSStringFromClass(config.ybhc_headerFooterClass);
}

- (CGSize)sizeForHeaderFooterWithConfig:(id<YBHCollectionHeaderFooterConfig>)config section:(NSInteger)section {
    if (config && [config.ybhc_headerFooterClass respondsToSelector:@selector(ybhc_sizeForHeaderFooterWithConfig:reuseIdentifier:section:)]) {
        return [config.ybhc_headerFooterClass ybhc_sizeForHeaderFooterWithConfig:config reuseIdentifier:[self reuseIdentifierForHeaderFooterConfig:config] section:section];
    }
    if ([config respondsToSelector:@selector(ybhc_defaultSize)] && !CGSizeEqualToSize(config.ybhc_defaultSize, CGSizeZero)) {
        return config.ybhc_defaultSize;
    }
    return CGSizeZero;
}

@end
