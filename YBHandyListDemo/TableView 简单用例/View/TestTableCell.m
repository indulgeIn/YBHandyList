//
//  TestTableCell.m
//  YBHandyTableViewDemo
//
//  Created by 波儿菜 on 2019/4/11.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "TestTableCell.h"
#import "TestTableModel.h"
#import "YBHandyList.h"

@interface TestTableCell () <YBHTableCellProtocol>
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) TestTableModel *model;
@end

@implementation TestTableCell

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.button.center = self.contentView.center;
}

#pragma mark - <YBHTableCellProtocol>

@synthesize ybht_reloadTableView = _ybht_reloadTableView;

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    TestTableModel *model = config.ybht_model;
    self.model = model;
    //拿到数据 Model 更新 UI
    self.textLabel.text = model.text;
    [self.button setTitle:(model.shouldMagnify ? @"缩小" : @"放大") forState:UIControlStateNormal];
}

+ (CGFloat)ybht_heightForCellWithConfig:(nonnull id<YBHTableCellConfig>)config reuseIdentifier:(nonnull NSString *)reuseIdentifier indexPath:(nonnull NSIndexPath *)indexPath {
    //根据提供的数据计算返回高度
    TestTableModel *model = config.ybht_model;
    return model.shouldMagnify ? 100 : UITableViewAutomaticDimension;
}

- (void)ybht_didSelectedAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n%@ 被点击了", self.textLabel.text);
}

#pragma mark - event

- (void)clickButton:(UIButton *)button {
    self.model.shouldMagnify = !self.model.shouldMagnify;
    //刷新列表
    self.ybht_reloadTableView();
}

#pragma mark - getter

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.bounds = CGRectMake(0, 0, 80, 40);
        [_button setTitle:@"刷新Table" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
