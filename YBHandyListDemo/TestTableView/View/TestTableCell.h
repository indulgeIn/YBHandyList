//
//  TestTableCell.h
//  YBHandyTableViewDemo
//
//  Created by 杨波 on 2019/4/11.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TestTableCell;

@protocol TestTableCellDelegate <NSObject>

- (void)testTableCellCell:(TestTableCell *)cell clickButton:(UIButton *)button;

@end

@interface TestTableCell : UITableViewCell

@end

NS_ASSUME_NONNULL_END
