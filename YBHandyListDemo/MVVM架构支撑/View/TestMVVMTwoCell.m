//
//  TestMVVMTwoCell.m
//  YBHandyListDemo
//
//  Created by 杨波 on 2019/6/19.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "TestMVVMTwoCell.h"
#import "TestMVVMTwoCellViewModel.h"

@interface TestMVVMTwoCell ()
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end

@implementation TestMVVMTwoCell

#pragma mark - <YBHTableCellProtocol>

- (void)ybht_setCellConfig:(id<YBHTableCellConfig>)config {
    TestMVVMTwoCellViewModel *vm = config;
    self.nameLabel.text = vm.showName;
    self.commentLabel.text = vm.showComment;
}

+ (CGFloat)ybht_heightForCellWithConfig:(id<YBHTableCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

@end
