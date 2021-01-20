//
//  ItemListViewController.m
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

#import "ItemListViewController.h"
#import "ItemListTableViewCell.h"
#import "ItemDetailViewController.h"

@interface ItemListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) RLMResults<Item *> *items;

@end

@implementation ItemListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"categoryId = %d", self.categoryId];
    self.items = [Item objectsWithPredicate:pred];
    
    self.navigationItem.title = self.categoryTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [[AppManager sharedInstance] incrementCategoryVisitedCount:self.category];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ItemListTableViewCell *cell = (ItemListTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"itemCell"];
    
    Item *item = [self.items objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = item.title;
    cell.priceLabel.text = [NSString stringWithFormat:@"$%.02f", item.price];
    cell.icon.image = [UIImage imageNamed:item.image];
    cell.ownerLabel.text = self.categoryTitle;  //item.owner;
    cell.ratingsLabel.attributedText = [[AppManager sharedInstance] starRatingWith:item.rating outOfTotal:5];
    cell.ratingsCountLabel.text = [NSString stringWithFormat:@"(%ld)", item.ratingCount];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndex = [self.tableView indexPathForSelectedRow];
    ItemDetailViewController *destVC = (ItemDetailViewController *) segue.destinationViewController;
    
    Item *item = [self.items objectAtIndex:selectedIndex.row];
    
    destVC.dataItem = item;
}

@end
