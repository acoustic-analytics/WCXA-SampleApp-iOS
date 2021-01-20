//
//  CartItemTableViewCell.m
//  CXA
//
//  Created by Chanikya on 10/26/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
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
