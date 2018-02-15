//
//  CartSummaryTableViewCell.h
//  CXA
//
//  Created by Chanikya on 10/26/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartSummaryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *subTotalLabel;
@property (weak, nonatomic) IBOutlet UILabel *shippingLabel;
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
@property (weak, nonatomic) IBOutlet UILabel *cartTotalLabel;

@end
