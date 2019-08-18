//
//  WellKnownSayingTwoCell.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "WellKnownSayingTwoCell.h"
#import "WellKnownSayingTwoCellModel.h"

@interface WellKnownSayingTwoCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/// cellModel 需要持有起来后面做回调处理
@property (nonatomic, strong) WellKnownSayingTwoCellModel *cellModel;
@end

@implementation WellKnownSayingTwoCell

#pragma mark - <YBHTableCellProtocol>

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    self.cellModel = config;
    
    self.nameLabel.text = self.cellModel.showName;
    self.commentLabel.text = self.cellModel.showComment;
}

+ (CGFloat)ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

#pragma mark - event

- (IBAction)clickRefreshButton:(UIButton *)sender {
    if (self.cellModel.clickRefreshButtonBlock) self.cellModel.clickRefreshButtonBlock();
}

@end
