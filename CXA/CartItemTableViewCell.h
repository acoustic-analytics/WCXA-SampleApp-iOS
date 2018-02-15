//
//  CartItemTableViewCell.h
//  CXA
//
//  Created by Chanikya on 10/26/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"

@interface CartItemTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *itemIcon;
@property (weak, nonatomic) IBOutlet UILabel *itemQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemOwnerLabel;
@property (strong, nonatomic) Item           *dataItem;

@property (nonatomic, weak) CartViewController *delegate;

- (IBAction)deleteItem:(id)sender;
- (IBAction)stepperValueChanged:(id)sender;

@end
