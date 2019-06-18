//
//  TestTableCell.m
//  YBHandyTableViewDemo
//
//  Created by 杨波 on 2019/4/11.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestTableCell.h"
#import "TestTableModel.h"

#import "UITableView+YBHandyList.h"

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

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    TestTableModel *model = config.ybht_model;
    self.textLabel.text = model.text;
}

+ (CGFloat)ybht_heightForCellWithConfig:(nonnull id<YBHTableCellConfig>)config reuseIdentifier:(nonnull NSString *)reuseIdentifier indexPath:(nonnull NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - event

- (void)clickButton:(UIButton *)button {

}

#pragma mark - getter

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.bounds = CGRectMake(0, 0, 80, 40);
        [_button setTitle:@"点击" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
