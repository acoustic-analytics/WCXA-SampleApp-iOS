//
//  MoreViewController.m
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

#import "CXAEnvViewController.h"
#import "CXAEnv.h"
#import "Realm/RLMRealm.h"
#import "AppDelegate.h"

@interface CXAEnvViewController () <UITextFieldDelegate>

@property (nonatomic, strong) NSString *configFilePath;

@end

@implementation CXAEnvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveBtnOutlet.layer.cornerRadius = 5;
    self.saveBtnOutlet.layer.shadowOffset = CGSizeMake(3, 3);
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tapScroll.cancelsTouchesInView = NO;
    [self.scrollView addGestureRecognizer:tapScroll];
    
    self.acoIdTextField.delegate = self;
    self.appKeyTextField.delegate = self;
    self.postMessageTextField.delegate = self;
    self.killSwitchTextField.delegate = self;
    
    NSString *mainPath = [[NSBundle mainBundle] pathForResource:@"TLFResources" ofType:@"bundle"];
    NSBundle *bundlePath = [[NSBundle alloc] initWithPath:mainPath];
    self.configFilePath = [bundlePath pathForResource:@"TealeafBasicConfig" ofType:@"plist"];
    
//    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isCXAEnvSetup"] boolValue]) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button addTarget:self
//                   action:@selector(closeButton)
//         forControlEvents:UIControlEventTouchUpInside];
//        [button setTitle:@"Close" forState:UIControlStateNormal];
//        button.frame = CGRectMake(16.0, 16.0, 30.0, 30.0);
//       // [self.view addSubview:button];
//    }
    
    // Screen is modally presented so add navigation bar
    if (self.isAppOpenedFirstTime) {
        self.isAppOpenedFirstTime = NO;
        UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"CXA Environment setup"];
        [navbar setItems:@[navItem]];
        [self.view addSubview:navbar];
        
        UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, -24, self.view.frame.size.width - 16, 36)]; //68
        infoLabel.text = @"Setup the environment to where session data should be sent. For more info, see About CXA app section in More tab";
        infoLabel.numberOfLines = 3;
        infoLabel.textColor = [UIColor grayColor]; //[UIColor colorWithRed:0.49 green:0.78 blue:1.00 alpha:1.0];;
        infoLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.scrollView addSubview:infoLabel];
        self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, 49.0, 0);
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top + 64 + 40, 0.0, self.scrollView.contentInset.bottom, 0.0);
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showSessionCopyDialog)];
    [self.sessionIdLabel addGestureRecognizer:longPress];
    self.sessionIdLabel.userInteractionEnabled = YES;
    
    UILongPressGestureRecognizer *lPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showPortalCopyDialog)];
    [self.portalUrlLabel addGestureRecognizer:lPress];
    self.portalUrlLabel.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    [self registerForKeyboardNotifications];
    
    [self.saveBtnOutlet setTitle:@"Save & Start new session" forState:UIControlStateNormal];
    
    if ([[TLFApplicationHelper sharedInstance] isTLFEnabled]) {
        self.sessionIdLabel.text = [[TLFApplicationHelper sharedInstance] currentSessionId];
        self.acoIdTextField.text = [[TLFApplicationHelper sharedInstance] valueForConfigurableItem:@"acoId"];
        self.appKeyTextField.text = [[TLFApplicationHelper sharedInstance] valueForConfigurableItem:@"AppKey"];
        self.postMessageTextField.text = [[TLFApplicationHelper sharedInstance] valueForConfigurableItem:@"PostMessageUrl"];
        self.killSwitchTextField.text = [[TLFApplicationHelper sharedInstance] valueForConfigurableItem:@"KillSwitchUrl"];
    }
    else {
        self.sessionIdLabel.text = @"No active session";
    }
}

- (void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) dismissKeyboard {
    [self.view endEditing:YES];
}

- (void) closeButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
        
    NSString *postMsgStr = @"";
    NSString *killSwitchStr = @"";
    NSString *appKeyStr = @"";
    
    if (self.postMessageTextField.text.length > 0) {
        postMsgStr = self.postMessageTextField.text;
    }
    if (self.killSwitchTextField.text.length > 0) {
        killSwitchStr = self.killSwitchTextField.text;
    }
    if (self.appKeyTextField.text.length > 0) {
        appKeyStr = self.appKeyTextField.text;
    }
    BOOL isEnvChanged = YES;
    BOOL isAcoIdChanged = YES;
    RLMResults<CXAEnv *> *results = [CXAEnv allObjects];
    if (results.count > 0) {
        if ([self.acoIdTextField.text isEqualToString:results[0].acoID]) {
            isAcoIdChanged = NO;
        }
        if ([appKeyStr isEqualToString:results[0].appKey] && [postMsgStr isEqualToString:results[0].postMessageURL] && [killSwitchStr isEqualToString:results[0].killSwitch]) {
            isEnvChanged = NO;            // user not changed the CXA environment
        }
    }
    
    if (isEnvChanged) {
        
        CXAEnv *env = [[CXAEnv alloc] init];
        env.acoID = self.acoIdTextField.text;
        env.appKey = appKeyStr;
        env.postMessageURL = postMsgStr;
        env.killSwitch = killSwitchStr;
        env.dummyId = @"1";
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:env];
        [realm commitWriteTransaction];
        if( [AppDelegate isValidOSVersionAndPlatform] == YES )
        {
            [[TLFApplicationHelper sharedInstance] setPostMessageUrl:self.postMessageTextField.text];
            [[TLFApplicationHelper sharedInstance] setKillSwitchUrl:self.killSwitchTextField.text];
            [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"AppKey" value:self.appKeyTextField.text];
            
            if ([[TLFApplicationHelper sharedInstance] isTLFEnabled]) {
                [[TLFApplicationHelper sharedInstance] startNewTLFSession];   // start new session when environment changed..
            }
            else {
                [[TLFApplicationHelper sharedInstance] enableTealeafFramework];   // enabling framework with default CXA environment
            }
            self.sessionIdLabel.text = [[TLFApplicationHelper sharedInstance] currentSessionId];
            
            [AppManager sharedInstance].openConfigSession = YES;
        }
    }

    if (isAcoIdChanged)
    {
        //[[TLFCustomEvent sharedInstance] logEvent:@"acoId" value:self.acoIdTextField.text];
        [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"acoId" value:self.acoIdTextField.text];
    }
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:NO];
    }
    
    [[TLFCustomEvent sharedInstance] logFormCompletion:YES withValidData:YES];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.scrollView.contentInset = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0, 49.0, 0);
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, self.scrollView.contentInset.bottom + kbSize.height + 20 - 49, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(self.scrollView.contentInset.top, 0.0, self.scrollView.contentInset.bottom - kbSize.height - 20 + 49, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void) showSessionCopyDialog {
    [self showCopyDialog:@"Copy Session Id"];
}

- (void) showPortalCopyDialog {
    [self showCopyDialog:@"Copy Portal URL"];
}

- (void) showCopyDialog:(NSString *) title {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:title
                                 message:@""
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Copy"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
                             [pasteboard setString:self.sessionIdLabel.text];
                             
                             //Do some thing here
                             [view dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:ok];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

@end
