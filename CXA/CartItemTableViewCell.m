//
//  CartItemTableViewCell.m
//  CXA
//
//  Created by Chanikya on 10/26/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "CartItemTableViewCell.h"

@implementation CartItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)deleteItem:(id)sender {
    [self.delegate deleteItemFromCart:self.dataItem];
}

- (IBAction)stepperValueChanged:(id)sender {
    NSUInteger value= ((UIStepper *)sender).value;
    if (value > 0) {
        self.itemQuantityLabel.text = [NSString stringWithFormat:@"%ld", (unsigned long)value];
        [self.delegate updateItem:self.dataItem withQuantity:value];
    }
}
@end
