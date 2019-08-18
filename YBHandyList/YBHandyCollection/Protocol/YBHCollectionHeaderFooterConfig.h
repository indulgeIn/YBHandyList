//
//  YBHCollectionHeaderFooterConfig.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "YBHCollectionHeaderFooterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 UICollectionView header/footer 配置协议
 */
@protocol YBHCollectionHeaderFooterConfig <NSObject>

@required

/** header/footer 类类型 */
- (Class<YBHCollectionHeaderFooterProtocol>)ybhc_headerFooterClass;

@optional

/** header/footer 对应的数据模型 */
- (id)ybhc_model;

/** header/footer 的大小 (优先级低于 YBHCollectionHeaderFooterProtocol 代理方法返回的高度) */
- (CGSize)ybhc_defaultSize;

/** header/footer 的复用标识 */
- (NSString *)ybhc_headerFooterReuseIdentifier;

@end


/**
 配置默认实现类，用于快速构建，若想拓展属性请自行创建类实现 YBHCollectionHeaderFooterConfig 协议
 */
@interface YBHCollectionHeaderFooterConfig : NSObject <YBHCollectionHeaderFooterConfig>

/** header/footer 类类型 */
@property (nonatomic, strong) Class<YBHCollectionHeaderFooterProtocol> headerFooterClass;

/** header/footer 对应的数据模型 */
@property (nonatomic, strong) id model;

/** header/footer 的大小 (优先级低于 YBHCollectionHeaderFooterProtocol 代理方法返回的高度) */
@property (nonatomic, assign) CGSize defaultSize;

/** header/footer 的复用标识 */
@property (nonatomic, copy) NSString *headerFooterReuseIdentifier;

@end

NS_ASSUME_NONNULL_END
