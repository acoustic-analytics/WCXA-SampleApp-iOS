//
//  ItemDetailViewController.m
//  CXA
//
//  Created by Chanikya on 10/24/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "ItemDetailViewController.h"
#import "ItemTitleTableViewCell.h"
#import "ItemImageTableViewCell.h"
#import "ItemPriceTableViewCell.h"
#import "ItemDescriptionTableViewCell.h"
#import "ItemAddToCartTableViewCell.h"
#import "CartItem.h"

@interface ItemDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (atomic, assign) BOOL canShowCheckOutBtn;
@property (nonatomic) CGPoint scrollViewLastOffSetPosition;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.navigationItem.title = self.dataItem.title;
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cartUpdated)
                                                 name:@"CartItemUpdated"
                                               object:nil];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) viewWillDisappear:(BOOL)animated {
    //[self.navigationController popViewControllerAnimated:NO];
    [[AppManager sharedInstance] saveRecentlyVisitedItem:self.dataItem];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 75.0; //100.0;
        case 1:
            return 170.0;
        case 2:
            return 65.0;
        case 4:
            return 150.0;
        case 3:
            return 60.0;
        default:
            return 60.0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(self.canShowCheckOutBtn)
        return 50.0;
    return 0.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 52)];
    //view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.95 alpha:1.0];
    
    UIButton *checkOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(8, 8, self.tableView.frame.size.width - 16, 36.0)];
    checkOutBtn.backgroundColor = [UIColor whiteColor]; //[UIColor colorWithRed:0.94 green:0.76 blue:0.00 alpha:1.0];
    
    [checkOutBtn addTarget:self action:@selector(gotoCart) forControlEvents:UIControlEventTouchUpInside];
    [checkOutBtn setTitle:@"Proceed to Checkout" forState:UIControlStateNormal];
    [checkOutBtn setTitleColor:[UIColor colorWithRed:0.25 green:0.47 blue:0.75 alpha:1.0] forState:UIControlStateNormal];
    [checkOutBtn.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    checkOutBtn.layer.cornerRadius = 5;
    checkOutBtn.layer.shadowOffset = CGSizeMake(3, 3);
    checkOutBtn.layer.borderColor = [UIColor colorWithRed:0.25 green:0.47 blue:0.75 alpha:1.0].CGColor;
    checkOutBtn.layer.borderWidth = 3;
    
    [view addSubview:checkOutBtn];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, view.frame.size.height - 1, self.tableView.frame.size.width, 1)];
    bottomLine.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:bottomLine];
    
    return view;
}

- (void) tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if(self.canShowCheckOutBtn) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[TLFCustomEvent sharedInstance] logScreenLayoutWithViewController:self andDelay:0.5f];
        });
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ItemTitleTableViewCell *cell = (ItemTitleTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"titleCell"];
            cell.titleLabel.text = self.dataItem.title;   // self.data[@"title"];
            cell.categoryLabel.text = self.dataItem.owner;    //self.data[@"owner"];
            cell.reviewsLabel.text = [NSString stringWithFormat:@"(%ld)", (long)self.dataItem.ratingCount];   // self.data[@"reviewsCount"]
            cell.ratingLabel.attributedText = [[AppManager sharedInstance] starRatingWith:self.dataItem.rating outOfTotal:5];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 1:
        {
            ItemImageTableViewCell *cell = (ItemImageTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
            cell.itemImageView.image = [UIImage imageNamed:self.dataItem.image];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 2:
        {
            ItemPriceTableViewCell *cell = (ItemPriceTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"priceCell"];
            cell.priceLabel.text = [NSString stringWithFormat:@"$%.02f", self.dataItem.price];  //self.data[@"price"];
            cell.stockAvailabilityLabel.text = self.dataItem.stockAvailability;   //self.data[@"stock"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 4:
        {
            ItemDescriptionTableViewCell *cell = (ItemDescriptionTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"descriptionCell"];
            cell.descriptionLabel.text = self.dataItem.shortDescription;  //self.data[@"description"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 3:
        {
            ItemAddToCartTableViewCell *cell = (ItemAddToCartTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"addToCartCell"];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        default:
            break;
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void) gotoCart {
    [self.tabBarController setSelectedIndex:2];
}

- (void) addItemToCart
{
    [[AppManager sharedInstance] addItemToCart:self.dataItem];
}

- (void) cartUpdated
{
    // self.canShowCheckOutBtn = YES;
    
    UIAlertController * alert=   [UIAlertController alertControllerWithTitle:@"Item in the cart" message:@"Item added to the cart" preferredStyle:UIAlertControllerStyleAlert];
    
//    UIAlertController * alert=   [UIAlertController
//                                  alertControllerWithTitle:@"Item added to the cart"
//                                  message:@""
//                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Dismiss"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"View Cart"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 [self.tabBarController setSelectedIndex:2];
                             }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [alert dismissViewControllerAnimated:YES completion:^{
//            [self.tableView reloadData];
//        }];
//    });
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.scrollViewLastOffSetPosition = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ((fabs(scrollView.contentOffset.y) != fabs(self.scrollViewLastOffSetPosition.y) + 20) || (fabs(scrollView.contentOffset.y) + 20 != fabs(self.scrollViewLastOffSetPosition.y))) {
        // [[TLFCustomEvent sharedInstance] logScreenLayoutWithViewController:self];
    }
}

@end
