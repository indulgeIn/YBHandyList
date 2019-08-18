//
//  YBHCollectionSection.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHCollectionCellConfig.h"
#import "YBHCollectionHeaderFooterConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBHCollectionSection : NSObject

/** UICollectionView 的 header 配置 */
@property (nonatomic, strong, nullable) id<YBHCollectionHeaderFooterConfig> header;

/** UICollectionView 的 footer 配置 */
@property (nonatomic, strong, nullable) id<YBHCollectionHeaderFooterConfig> footer;

/** UICollectionView 的 cell 配置数组 */
@property (nonatomic, strong, readonly) NSMutableArray<id<YBHCollectionCellConfig>> *rowArray;

/** cell 间距 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/** cell 间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/** section 外边距 */
@property (nonatomic, assign) UIEdgeInsets inset;

@end

NS_ASSUME_NONNULL_END
