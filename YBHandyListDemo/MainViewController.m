//
//  MainViewController.m
//  YBHandyTableViewDemo
//
//  Created by 波儿菜 on 2019/4/11.
//  Copyright © 2019 波儿菜. All rights reserved.
//

#import "MainViewController.h"
#import "TestTableController.h"
#import "TestCollectionController.h"
#import "WellKnownSayingController.h"

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
- (IBAction)clickMVVM:(id)sender {
    [self.navigationController pushViewController:WellKnownSayingController.new animated:YES];
}

@end
