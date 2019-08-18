//
//  WellKnownSayingControllerViewModel.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "WellKnownSayingControllerViewModel.h"

@class WellKnownSayingOneCell;

@implementation WellKnownSayingControllerViewModel

- (void)startRequestWithSuccess:(void (^)(NSArray<WellKnownSayingModel *> * _Nonnull))success {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0.1), ^{
        
        //获取数据
        NSString *path = [[NSBundle mainBundle] pathForResource:@"WellKnownSaying" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        
        //数据转模型
        NSMutableArray *modelArray = [NSMutableArray array];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            WellKnownSayingModel *model = [WellKnownSayingModel new];
            model.name = key;
            model.comment = obj;
            model.type = arc4random() % 3;  //模拟服务器动态类型下发
            [modelArray addObject:model];
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            success(modelArray);
        });
    });
    
}

@end
