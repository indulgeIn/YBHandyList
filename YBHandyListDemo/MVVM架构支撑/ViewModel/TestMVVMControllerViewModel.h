//
//  TestMVVMControllerViewModel.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestMVVMControllerViewModel : NSObject

/// 开始网络请求
- (void)startRequestWithSuccess:(void(^)(NSArray *viewModelArray))success;

@end

NS_ASSUME_NONNULL_END
