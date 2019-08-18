//
//  TestTableNibCell.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/18.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "TestTableNibCell.h"
#import "TestTableNibCellConfig.h"
#import "YBHandyList.h"

@interface TestTableNibCell () <YBHTableCellProtocol>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) TestTableNibCellConfig *config;
@end

@implementation TestTableNibCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)clickSeeMoreButton:(id)sender {
    if ([self.config.delegate respondsToSelector:@selector(testTableNibCell:clickSeeMoreButton:)]) {
        [self.config.delegate testTableNibCell:self clickSeeMoreButton:sender];
    }
}

#pragma mark - <YBHTableCellProtocol>

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    //将配置对象持有起来，内部业务要使用
    self.config = (TestTableNibCellConfig *)config;
    
    self.titleLabel.text = self.config.title;
}

+ (CGFloat)ybht_heightForCellWithConfig:(nonnull id<YBHTableCellConfig>)config reuseIdentifier:(nonnull NSString *)reuseIdentifier indexPath:(nonnull NSIndexPath *)indexPath {
    return 100;
}


@end
