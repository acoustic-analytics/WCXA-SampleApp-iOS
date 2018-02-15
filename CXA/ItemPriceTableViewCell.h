//
//  ItemPriceTableViewCell.h
//  CXA
//
//  Created by Chanikya on 10/24/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemPriceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockAvailabilityLabel;

@end
