//
//  CXATabBarController.m
//  CXA
//
//  Created by Chanikya on 11/10/16.
//  Copyright © 2016 IBM. All rights reserved.
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
