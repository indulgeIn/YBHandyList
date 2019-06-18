//
//  TestTableController.m
//  YBHandyTableViewDemo
//
//  Created by 杨波 on 2019/4/11.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestTableController.h"
#import "TestTableModel.h"
#import "TestTableCell.h"
#import "TestTableNibCell.h"
#import "TestTableNibHeader.h"

#import "UITableView+YBHandyList.h"

@interface TestTableController ()
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TestTableController

#pragma mark - life cycle

- (void)dealloc {
    NSLog(@"释放：%@", self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"YBHandyTable";
    [self.view addSubview:self.tableView];
    [self loadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - private

- (void)loadData {
    
    //❶ 模拟构建数据模型
    
    NSMutableArray *modelArray = [NSMutableArray array];
    for (int i = 0; i < 10; ++i) {
        TestTableModel *model = [TestTableModel new];
        model.text = [NSString stringWithFormat:@"这是第%d个", i];
        [modelArray addObject:model];
    }
    
    //❷ 构建配置对象
    
    NSMutableArray *configArray = [NSMutableArray array];
    for (TestTableModel *model in modelArray) {
        YBHTableCellConfig *config = [YBHTableCellConfig new];
        config.ybht_model = model;
        config.ybht_cellClass = TestTableCell.class;
        [configArray addObject:config];
    }
    
    YBHTableHeaderFooterConfig *headerConfig = [YBHTableHeaderFooterConfig new];
    headerConfig.ybht_defaultHeight = @(100);
    headerConfig.ybht_headerFooterClass = TestTableNibHeader.self;
    
    //❸ 赋值并刷新
    
//    YBHTableSection *section = [YBHTableSection new];
//    section.header = headerConfig;
//    [section.rowArray addObjectsFromArray:configArray];
//    [self.tableView.ybht_sectionArray addObject:section];
    
    //使用语法糖
    self.tableView.ybht_header = headerConfig;
    [self.tableView.ybht_rowArray addObjectsFromArray:configArray];
    
    [self.tableView reloadData];
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 44;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

@end
