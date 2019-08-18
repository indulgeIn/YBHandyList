//
//  WellKnownSayingModel.h
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WellKnownSayingModelType) {
    WellKnownSayingModelTypeOne,
    WellKnownSayingModelTypeTwo,
    WellKnownSayingModelTypeThree
};

@interface WellKnownSayingModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, assign) WellKnownSayingModelType type;
@end

NS_ASSUME_NONNULL_END
