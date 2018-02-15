//
//  CartCheckOutTableViewCell.h
//  CXA
//
//  Created by Chanikya on 10/26/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"

@interface CartCheckOutTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *checkOutOutlet;
@property (nonatomic, weak) CartViewController *delegate;
- (IBAction)checkOut:(id)sender;

@end
