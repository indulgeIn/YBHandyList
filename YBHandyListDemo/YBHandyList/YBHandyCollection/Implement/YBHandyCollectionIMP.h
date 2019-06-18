//
//  YBHandyCollectionIMP.h
//  YBHandyList
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "YBHCollectionSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBHandyCollectionIMP : NSObject <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** 数据源（可以访问该属性，但不要更改其指针指向，也不要去更改内部元素） */
@property (nonatomic, strong) NSMutableArray<YBHCollectionSection *> *sectionArray;

@end

NS_ASSUME_NONNULL_END
