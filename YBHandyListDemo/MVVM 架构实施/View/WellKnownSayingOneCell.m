//
//  WellKnownSayingOneCell.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "WellKnownSayingOneCell.h"
#import "WellKnownSayingOneCellModel.h"

@interface WellKnownSayingOneCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation WellKnownSayingOneCell

#pragma mark - <YBHTableCellProtocol>

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    WellKnownSayingOneCellModel *vm = config;
    self.nameLabel.text = vm.showName;
    self.commentLabel.text = vm.showComment;
}

+ (CGFloat)ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
