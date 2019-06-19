//
//  TestMVVMControllerViewModel.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestMVVMControllerViewModel.h"
#import "TestMVVMModel.h"
#import "TestMVVMOneCellViewModel.h"
#import "TestMVVMTwoCellViewModel.h"
#import "TestMVVMThreeCellViewModel.h"

@class TestMVVMOneCell;

@implementation TestMVVMControllerViewModel

- (void)startRequestWithSuccess:(void (^)(NSArray * _Nonnull))success {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        //获取数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TestMVVM" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        //数据转模型
        NSMutableArray *modelArray = [NSMutableArray array];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            TestMVVMModel *model = [TestMVVMModel new];
            model.name = key;
            model.comment = obj;
            model.type = arc4random() % 3;  //模拟服务器动态类型下发
            [modelArray addObject:model];
        }];
        
        //加工模型，初始化 ViewModel (为了方便，这些 ViewModel 都是一样的属性)
        NSMutableArray *viewModelArray = [NSMutableArray array];
        for (TestMVVMModel *model in modelArray) {
            id viewModel;
            switch (model.type) {
                case TestMVVMModelTypeOne: {
                    TestMVVMOneCellViewModel *vm = [TestMVVMOneCellViewModel new];
                    vm.showName = [NSString stringWithFormat:@"—— %@", model.name];
                    vm.showComment = model.comment;
                    viewModel = vm;
                }
                    break;
                case TestMVVMModelTypeTwo: {
                    TestMVVMTwoCellViewModel *vm = [TestMVVMTwoCellViewModel new];
                    vm.showName = [NSString stringWithFormat:@"%@ :", model.name];
                    vm.showComment = model.comment;
                    viewModel = vm;
                }
                    break;
                case TestMVVMModelTypeThree: {
                    TestMVVMThreeCellViewModel *vm = [TestMVVMThreeCellViewModel new];
                    vm.showName = [NSString stringWithFormat:@"(%@)", model.name];
                    vm.showComment = model.comment;
                    viewModel = vm;
                }
                    break;
            }
            [viewModelArray addObject:viewModel];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(viewModelArray);
        });
    });
    
}

@end
