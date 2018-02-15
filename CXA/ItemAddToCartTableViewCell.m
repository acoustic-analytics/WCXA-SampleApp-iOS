//
//  ItemAddToCartTableViewCell.m
//  CXA
//
//  Created by Chanikya on 10/24/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "ItemAddToCartTableViewCell.h"

@implementation ItemAddToCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addToCartOutlet.layer.cornerRadius = 5;
    self.addToCartOutlet.layer.shadowOffset = CGSizeMake(3, 3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addToCart:(id)sender {
    [self.delegate addItemToCart];
}
@end
