//
//  SecondViewController.m
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "AccountViewController.h"
#import "User.h"
#import "Realm/RLMRealm.h"
#import "Realm/RLMResults.h"

@interface AccountViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginOutlet;

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Account";
    
    self.containerView.layer.cornerRadius = 0;
    self.containerView.layer.borderWidth = 1;
    self.containerView.layer.borderColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.95 alpha:1.0].CGColor;
    
    self.loginOutlet.layer.cornerRadius = 2;
}

- (void) viewWillAppear:(BOOL)animated
{
    [[TLFCustomEvent sharedInstance] logScreenLayoutWithViewController:self andDelay:0.5f]; // Manually logging the screen
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)login:(id)sender {
    if (self.emailTextField.text.length !=0 && self.passwordTextField.text.length !=0) {
        dispatch_async(dispatch_queue_create("background", 0), ^{
            
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"email = %@ AND password = %@", self.emailTextField.text, self.passwordTextField.text];
            RLMResults<User *> *results = [User objectsWithPredicate:pred];
            
            if (results.count > 0) {
                [AppManager sharedInstance].userId = results[0].userId;
                [[NSUserDefaults standardUserDefaults] setObject:results[0].userId forKey:@"userId"];
                NSLog(@"Login Successfull");
                [[NSUserDefaults standardUserDefaults] setObject:@(NO) forKey:@"isLoginSkipped"];
                [AppManager sharedInstance].skipAccountVCLogging = NO;
                //[[TLFCustomEvent sharedInstance] logEvent:@"UserName" value:results[0].userId];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        });
    }
    else {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Invalid login details"
                                      message:@"Please enter correct login credentials"
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

- (IBAction)closePopUp:(id)sender {
    [AppManager sharedInstance].currentTabController.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) popToRootVC
{
    UIViewController *vc = self.presentingViewController;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)skipLogin:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isLoginSkipped"];
    [AppManager sharedInstance].skipAccountVCLogging = NO;
    [self popToRootVC];
}

@end
