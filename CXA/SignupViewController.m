//
//  SignupViewController.m
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "SignupViewController.h"
#import "User.h"
#import "Realm/RLMRealm.h"

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpOutlet;

@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containerView.layer.cornerRadius = 0;
    self.containerView.layer.borderWidth = 1;
    self.containerView.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.95 alpha:1.0].CGColor;
    
    self.signUpOutlet.layer.cornerRadius = 2;
}

- (void) viewWillAppear:(BOOL)animated
{
    [[TLFCustomEvent sharedInstance] logScreenLayoutWithViewController:self andDelay:0.5f];  // Manually logging the screen
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createAccount:(id)sender {
    if (self.emailTextField.text.length != 0 && self.passwordTextField.text.length !=0) {
        if ([self.passwordTextField.text isEqualToString:self.confirmPwdTextField.text]) {
            User *user = [[User alloc] init];
            user.userId = [[NSUUID UUID] UUIDString];
            user.email = self.emailTextField.text;
            user.password = self.passwordTextField.text;
            
            [AppManager sharedInstance].skipAccountVCLogging = NO;
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject:user];
                [[NSUserDefaults standardUserDefaults] setObject:user.userId forKey:@"userId"];
                [AppManager sharedInstance].userId = user.userId;
                //[[TLFCustomEvent sharedInstance] logEvent:@"UserName" value:user.userId];
                [self popToRootVC];
            }];
        }
    }
    else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Invalid details"
                                      message:@"Please enter all required fields"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}
- (IBAction)skipLogin:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isLoginSkipped"];
    [AppManager sharedInstance].skipAccountVCLogging = NO;
    [self popToRootVC];
}

- (void) popToRootVC
{
    UIViewController *vc = self.presentingViewController;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:NO completion:nil];
}

@end
