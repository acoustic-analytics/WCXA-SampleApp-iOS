//
//  ItemListViewController.h
//  CXA
//
//  Created by Chanikya on 10/27/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) NSInteger          categoryId;
@property (strong, nonatomic) NSString           *categoryTitle;
@property (strong, nonatomic) Category           *category;

@end
