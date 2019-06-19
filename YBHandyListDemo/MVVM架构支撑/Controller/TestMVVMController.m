//
//  TestMVVMController.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestMVVMController.h"
#import "YBHandyList.h"
#import "TestMVVMControllerViewModel.h"

@interface TestMVVMController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TestMVVMControllerViewModel *viewModel;
@end

@implementation TestMVVMController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
    [self loadData];
}

- (void)updateUI {
    self.navigationItem.title = @"MVVM";
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

- (void)loadData {
    [self.viewModel startRequestWithSuccess:^(NSArray * _Nonnull viewModelArray) {
        //赋值并刷新
        [self.tableView.ybht_rowArray removeAllObjects];
        [self.tableView.ybht_rowArray addObjectsFromArray:viewModelArray];
        [self.tableView reloadData];
    }];
}

#pragma mark - event

- (void)clickRefreshItem {
    [self loadData];    //为了代码简洁此处不考虑请求并发
}

#pragma mark - getters & setters

- (TestMVVMControllerViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [TestMVVMControllerViewModel new];
    }
    return _viewModel;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 44;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
    }
    return _tableView;
}

@end
