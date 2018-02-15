//
//  ItemAddToCartTableViewCell.h
//  CXA
//
//  Created by Chanikya on 10/24/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@interface ItemAddToCartTableViewCell : UITableViewCell

@property (nonatomic, weak) ItemDetailViewController *delegate;
@property (weak, nonatomic) IBOutlet UIButton *addToCartOutlet;

- (IBAction)addToCart:(id)sender;

@end
