//
//  MainViewController.m
//  YBHandyTableViewDemo
//
//  Created by 杨波 on 2019/4/11.
//  Copyright © 2019 杨波. All rights reserved.
//

#import "MainViewController.h"
#import "TestTableController.h"
#import "TestCollectionController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)clickButton:(id)sender {
    [self.navigationController pushViewController:TestTableController.new animated:YES];
}
- (IBAction)clickCollection:(id)sender {
    [self.navigationController pushViewController:TestCollectionController.new animated:YES];
}

@end
