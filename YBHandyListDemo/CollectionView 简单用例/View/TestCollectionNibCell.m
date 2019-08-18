//
//  TestCollectionNibCell.m
//  YBHandyListDemo
//
//  Created by 波儿菜 on 2019/6/19.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "TestCollectionNibCell.h"
#import "TestCollectionModel.h"
#import "YBHandyList.h"

@interface TestCollectionNibCell () <YBHCollectionCellProtocol>
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end

@implementation TestCollectionNibCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = UIColor.orangeColor;
    self.contentView.layer.cornerRadius = 10;
}

#pragma mark - <YBHCollectionCellProtocol>

- (void)ybhc_setCellConfig:(id<YBHCollectionCellConfig>)config {
    TestCollectionModel *model = config.ybhc_model;
    self.textLabel.text = model.text;
}

+ (CGSize)ybhc_sizeForCellWithConfig:(id<YBHCollectionCellConfig>)config reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath sectionPack:(nonnull YBHCollectionSection *)sectionPack {
    // 一排三个
    CGFloat width = UIScreen.mainScreen.bounds.size.width - sectionPack.minimumInteritemSpacing * 2 - sectionPack.inset.left - sectionPack.inset.right;
    width = floor(width / 3.0);
    return CGSizeMake(width, 80);
}

@end
