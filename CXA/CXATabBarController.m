//
//  CXATabBarController.m
//  CXA
//
//  Created by Chanikya on 11/10/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "CXATabBarController.h"
#import "UserAccountViewController.h"

@interface CXATabBarController () <UITabBarControllerDelegate, UITabBarDelegate>

@end

@implementation CXATabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBar setTintColor:[UIColor colorWithRed:0.33 green:0.59 blue:0.90 alpha:1.0]]; //[UIColor colorWithRed:0.25 green:0.47 blue:0.75 alpha:1.0]];
    
    self.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
}

@end
