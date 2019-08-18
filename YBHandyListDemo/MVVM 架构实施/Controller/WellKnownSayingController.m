//
//  WellKnownSayingController.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "WellKnownSayingTableIMP.h"
#import "WellKnownSayingController.h"
#import "YBHandyList.h"
#import "WellKnownSayingControllerViewModel.h"

@interface WellKnownSayingController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WellKnownSayingControllerViewModel *viewModel;
@property (nonatomic, strong) NSArray<WellKnownSayingModel *> *dataArray;
@end

@implementation WellKnownSayingController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    [self loadListData];
}

- (void)initLayout {
    self.navigationItem.title = @"名人名言";
    self.view.backgroundColor = UIColor.whiteColor;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(clickRefreshItem)];
    self.navigationItem.rightBarButtonItem = item;
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - private

- (void)updateLayout {
    
    // 1️⃣ 初始化所有 ViewModel (这部分代码可以放在 WellKnownSayingControllerViewModel 中，不过可能会增加胶水代码)
    
    NSMutableArray *viewModelArray = [NSMutableArray array];
    
    for (WellKnownSayingModel *model in self.dataArray) {
        // 根据和服务器约定的不同类型创建不同的 ViewModel
        switch (model.type) {
            case WellKnownSayingModelTypeOne: { // 类型1
                
                WellKnownSayingOneCellModel *vm = [WellKnownSayingOneCellModel new];
                vm.showName = [NSString stringWithFormat:@"—— %@", model.name];
                vm.showComment = model.comment;
                
                [viewModelArray addObject:vm];
            }
                break;
            case WellKnownSayingModelTypeTwo: { // 类型2
                
                WellKnownSayingTwoCellModel *vm = [WellKnownSayingTwoCellModel new];
                vm.showName = [NSString stringWithFormat:@"%@ :", model.name];
                vm.showComment = model.comment;
                // 使用闭包做数据传递（也可用代理方式）
                __weak typeof(self) wSelf = self;
                vm.clickRefreshButtonBlock = ^{
                    // 处理 Cell 中的点击事件
                    __strong typeof(wSelf) self = wSelf;
                    if (!self) return;
                    [self loadListData];
                };
                
                [viewModelArray addObject:vm];
            }
                break;
            case WellKnownSayingModelTypeThree: { // 类型3
                
                WellKnownSayingThreeCellModel *vm = [WellKnownSayingThreeCellModel new];
                vm.showName = [NSString stringWithFormat:@"(%@)", model.name];
                vm.showComment = model.comment;
                
                [viewModelArray addObject:vm];
            }
                break;
        }
    }
    
    // 2️⃣ 赋值并刷新
    
    [self.tableView.ybht_rowArray removeAllObjects];
    [self.tableView.ybht_rowArray addObjectsFromArray:viewModelArray];
    [self.tableView reloadData];
}

- (void)loadListData {
    __weak typeof(self) wSelf = self;
    [self.viewModel startRequestWithSuccess:^(NSArray<WellKnownSayingModel *> * _Nonnull dataArray) {
        __strong typeof(wSelf) self = wSelf;
        if (!self) return;
        
        self.dataArray = dataArray;
        [self updateLayout];
    }];
}

#pragma mark - user event

- (void)clickRefreshItem {
    //为了代码简洁此处不考虑请求并发
    [self loadListData];
}

#pragma mark - getters & setters

- (WellKnownSayingControllerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [WellKnownSayingControllerViewModel new];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 44;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        // 当需要实现更多的 UITableView 代理方法时使用
        WellKnownSayingTableIMP *tableIMP = [WellKnownSayingTableIMP new];
        __weak typeof(self) wSelf = self;
        tableIMP.endDragBlock = ^(CGFloat scale) {
            __strong typeof(wSelf) self = wSelf;
            if (!self) return;
            self.navigationItem.title = [NSString stringWithFormat:@"名人名言 %.2lf", scale];
        };
        _tableView.ybht_tableIMP = tableIMP;
    }
    return _tableView;
}

@end
