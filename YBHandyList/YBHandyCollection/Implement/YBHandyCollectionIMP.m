//
//  YBHandyCollectionIMP.m
//  YBHandyList
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
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
        
        _enabledFlowLayoutProperties = NO;
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
    id<YBHCollectionCellConfig> config = hcSection.rowArray[indexPath.row];

    Class cellClass = [self validClassForCellConfig:config];
    NSString *identifier = [self reuseIdentifierForCellConfig:config];
    
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

        if ([tmpCell respondsToSelector:@selector(ybhc_setCellConfig:indexPath:commonInfo:)]) {
            [tmpCell ybhc_setCellConfig:config indexPath:indexPath commonInfo:self.commonInfo];
        }
        if ([tmpCell respondsToSelector:@selector(ybhc_setCellConfig:)]) {
            [tmpCell ybhc_setCellConfig:config];
        }
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
    
    Class cls = [self validClassForHeaderFooterConfig:config];
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
        
        if ([tmpView respondsToSelector:@selector(ybhc_setHeaderFooterConfig:indexPath:commonInfo:)]) {
            [tmpView ybhc_setHeaderFooterConfig:config indexPath:indexPath commonInfo:self.commonInfo];
        }
        if ([tmpView respondsToSelector:@selector(ybhc_setHeaderFooterConfig:)]) {
            [tmpView ybhc_setHeaderFooterConfig:config];
        }
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
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell respondsToSelector:@selector(ybhc_didSelectedAtIndexPath:)]) {
        [(id<YBHCollectionCellProtocol>)cell ybhc_didSelectedAtIndexPath:indexPath];
    }
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.enabledFlowLayoutProperties && [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.self]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).itemSize;
    }
    
    YBHCollectionSection *htSection = self.sectionArray[indexPath.section];
    id<YBHCollectionCellConfig> config = htSection.rowArray[indexPath.row];
    
    if ([config.ybhc_cellClass respondsToSelector:@selector(ybhc_sizeForCellWithConfig:reuseIdentifier:indexPath:sectionPack:commonInfo:)]) {
        return [config.ybhc_cellClass ybhc_sizeForCellWithConfig:config reuseIdentifier:[self reuseIdentifierForCellConfig:config] indexPath:indexPath sectionPack:htSection commonInfo:self.commonInfo];
    }
    if ([config.ybhc_cellClass respondsToSelector:@selector(ybhc_sizeForCellWithConfig:reuseIdentifier:indexPath:sectionPack:)]) {
        return [config.ybhc_cellClass ybhc_sizeForCellWithConfig:config reuseIdentifier:[self reuseIdentifierForCellConfig:config] indexPath:indexPath sectionPack:htSection];
    }
    if ([config respondsToSelector:@selector(ybhc_defaultSize)] && !CGSizeEqualToSize(config.ybhc_defaultSize, CGSizeZero)) {
        return config.ybhc_defaultSize;
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.enabledFlowLayoutProperties && [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.self]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).headerReferenceSize;
    }
    
    YBHCollectionSection *htSection = self.sectionArray[section];
    id<YBHCollectionHeaderFooterConfig> config = htSection.header;
    
    return [self sizeForHeaderFooterWithConfig:config section:section sectionPack:htSection];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (self.enabledFlowLayoutProperties && [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.self]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).footerReferenceSize;
    }
    
    YBHCollectionSection *htSection = self.sectionArray[section];
    id<YBHCollectionHeaderFooterConfig> config = htSection.footer;
    
    return [self sizeForHeaderFooterWithConfig:config section:section sectionPack:htSection];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.enabledFlowLayoutProperties && [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.self]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).minimumLineSpacing;
    }
    
    return self.sectionArray[section].minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.enabledFlowLayoutProperties && [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.self]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).minimumInteritemSpacing;
    }
    
    return self.sectionArray[section].minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.enabledFlowLayoutProperties && [collectionViewLayout isKindOfClass:UICollectionViewFlowLayout.self]) {
        return ((UICollectionViewFlowLayout *)collectionViewLayout).sectionInset;
    }
    
    return self.sectionArray[section].inset;
}

#pragma mark - private

- (Class)validClassForCellConfig:(id<YBHCollectionCellConfig>)config {
    return config.ybhc_cellClass ?: UICollectionViewCell.self;
}

- (Class)validClassForHeaderFooterConfig:(id<YBHCollectionHeaderFooterConfig>)config {
    return config.ybhc_headerFooterClass ?: UICollectionReusableView.self;
}

- (NSString *)reuseIdentifierForCellConfig:(id<YBHCollectionCellConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybhc_cellReuseIdentifier)]) {
        identifier = config.ybhc_cellReuseIdentifier;
    }
    return identifier ?: NSStringFromClass([self validClassForCellConfig:config]);
}

- (NSString *)reuseIdentifierForHeaderFooterConfig:(id<YBHCollectionHeaderFooterConfig>)config {
    NSString *identifier;
    if (config && [config respondsToSelector:@selector(ybhc_headerFooterReuseIdentifier)]) {
        identifier = [config ybhc_headerFooterReuseIdentifier];
    }
    return identifier ?: NSStringFromClass([self validClassForHeaderFooterConfig:config]);
}

- (CGSize)sizeForHeaderFooterWithConfig:(id<YBHCollectionHeaderFooterConfig>)config section:(NSInteger)section sectionPack:(YBHCollectionSection *)sectionPack {
    if (config && [config.ybhc_headerFooterClass respondsToSelector:@selector(ybhc_sizeForHeaderFooterWithConfig:reuseIdentifier:section:sectionPack:commonInfo:)]) {
        return [config.ybhc_headerFooterClass ybhc_sizeForHeaderFooterWithConfig:config reuseIdentifier:[self reuseIdentifierForHeaderFooterConfig:config] section:section sectionPack:sectionPack commonInfo:self.commonInfo];
    }
    if (config && [config.ybhc_headerFooterClass respondsToSelector:@selector(ybhc_sizeForHeaderFooterWithConfig:reuseIdentifier:section:sectionPack:)]) {
        return [config.ybhc_headerFooterClass ybhc_sizeForHeaderFooterWithConfig:config reuseIdentifier:[self reuseIdentifierForHeaderFooterConfig:config] section:section sectionPack:sectionPack];
    }
    if ([config respondsToSelector:@selector(ybhc_defaultSize)] && !CGSizeEqualToSize(config.ybhc_defaultSize, CGSizeZero)) {
        return config.ybhc_defaultSize;
    }
    return CGSizeZero;
}

#pragma mark - getter

- (NSMutableArray<YBHCollectionSection *> *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

- (YBHCCommonInfo *)commonInfo {
    if (!_commonInfo) {
        _commonInfo = [YBHCCommonInfo new];
    }
    return _commonInfo;
}

@end
