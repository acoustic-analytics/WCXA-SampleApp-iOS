//
//  ItemListViewController.h
//  CXA
//
//  Created by Chanikya on 10/27/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import <UIKit/UIKit.h>

@interface ItemListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger          categoryId;
@property (strong, nonatomic) NSString           *categoryTitle;
@property (strong, nonatomic) Category           *category;

@end
