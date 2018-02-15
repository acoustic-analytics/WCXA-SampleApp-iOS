//
//  MoreViewController.h
//  CXA
//
//  Created by Chanikya on 1/24/17.
//  Copyright © 2017 IBM. All rights reserved.
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
