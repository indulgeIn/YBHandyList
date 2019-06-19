//
//  TestMVVMThreeCell.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestMVVMThreeCell.h"
#import "TestMVVMThreeCellViewModel.h"

@interface TestMVVMThreeCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation TestMVVMThreeCell

#pragma mark - <YBHTableCellProtocol>

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    TestMVVMThreeCellViewModel *vm = config;
    self.nameLabel.text = vm.showName;
    self.commentLabel.text = vm.showComment;
}

+ (CGFloat)ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
