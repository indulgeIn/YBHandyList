//
//  TestMVVMModel.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TestMVVMModelType) {
    TestMVVMModelTypeOne,
    TestMVVMModelTypeTwo,
    TestMVVMModelTypeThree
};

@interface TestMVVMModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, assign) TestMVVMModelType type;
@end

NS_ASSUME_NONNULL_END
