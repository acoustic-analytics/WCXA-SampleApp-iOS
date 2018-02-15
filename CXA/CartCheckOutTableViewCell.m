//
//  CartCheckOutTableViewCell.m
//  CXA
//
//  Created by Chanikya on 10/26/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "CartCheckOutTableViewCell.h"

@implementation CartCheckOutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.checkOutOutlet.layer.cornerRadius = 5;
    self.checkOutOutlet.layer.shadowOffset = CGSizeMake(3, 3);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)checkOut:(id)sender {
    [self.delegate checkOut];
}
@end
