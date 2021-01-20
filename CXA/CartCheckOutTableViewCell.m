//
//  CartCheckOutTableViewCell.m
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
