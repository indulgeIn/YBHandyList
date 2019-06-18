//
//  YBHCollectionHeaderFooterConfig.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHCollectionHeaderFooterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 UICollectionView header/footer 配置协议
 */
@protocol YBHCollectionHeaderFooterConfig <NSObject>

@required

/** header/footer 类类型 */
@property (nonatomic, strong) Class<YBHCollectionHeaderFooterProtocol> ybhc_headerFooterClass;

@optional

/** header/footer 对应的数据模型 */
@property (nonatomic, strong) id ybhc_model;

/** header/footer 的复用标识 */
@property (nonatomic, copy) NSString *ybhc_headerFooterReuseIdentifier;

/** header/footer 的大小 (优先级低于 YBHCollectionHeaderFooterProtocol 代理方法返回的高度) */
@property (nonatomic, assign) CGSize ybhc_defaultSize;

@end


/**
 配置默认实现类，一般业务就够用了
 */
@interface YBHCollectionHeaderFooterConfig : NSObject <YBHCollectionHeaderFooterConfig>

@end

NS_ASSUME_NONNULL_END
