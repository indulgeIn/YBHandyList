//
//  TestTableNibCell.h
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/18.
//  Copyright © 2019 杨波. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TestTableNibCell;

@protocol TestTableNibCellDelegate <NSObject>

- (void)testTableNibCell:(TestTableNibCell *)cell clickSeeMoreButton:(UIButton *)button;

@end

@interface TestTableNibCell : UITableViewCell

@end

NS_ASSUME_NONNULL_END
