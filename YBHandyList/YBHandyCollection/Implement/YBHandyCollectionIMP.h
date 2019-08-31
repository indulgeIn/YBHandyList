//
//  YBHandyCollectionIMP.h
//  YBHandyList
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHCollectionSection.h"
#import "YBHCCommonInfo.h"

NS_ASSUME_NONNULL_BEGIN

/**
 代理实现类，可以直接抽出来作为 UICollectionView 的 delegate 和 dataSource，若想实现更多的代理方法，继承于该类在子类中拓展就行了。
 */
@interface YBHandyCollectionIMP : NSObject <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 数据源 */
@property (nonatomic, strong) NSMutableArray<YBHCollectionSection *> *sectionArray;

/** 公共信息对象，将会下发到 Cell/Header/Footer */
@property (nonatomic, strong) YBHCCommonInfo *commonInfo;

/** 是否激活 UICollectionViewFlowLayout 的布局属性，默认为 NO */
@property (nonatomic, assign) BOOL enabledFlowLayoutProperties;

@end

NS_ASSUME_NONNULL_END
