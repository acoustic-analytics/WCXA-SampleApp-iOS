//
//  MoreViewController.h
//  CXA
//
//  Created by Chanikya on 1/24/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import <UIKit/UIKit.h>

@interface CXAEnvViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *ibmIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *appKeyTextField;
@property (weak, nonatomic) IBOutlet UITextField *postMessageTextField;
@property (weak, nonatomic) IBOutlet UITextField *killSwitchTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtnOutlet;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *sessionIdLabel;
@property (atomic, assign)  BOOL isAppOpenedFirstTime;
@property (weak, nonatomic) IBOutlet UILabel *portalUrlLabel;

- (IBAction)save:(id)sender;

@end
