//
//  EndUserConsentViewController.m
//  CXA
//
//  Created by Shridhar Damale on 2/12/19.
//  Copyright (C) 2019 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "EndUserConsentViewController.h"
#import "SupportViewController.h"
#import "AppDelegate.h"

@interface EndUserConsentViewController ()
@property (strong, nonatomic) IBOutlet UILabel *optInOutLabel;
@property (strong, nonatomic) IBOutlet UISwitch *theConsentSwitch;

@end

@implementation EndUserConsentViewController
@synthesize optInOutLabel;
@synthesize theConsentSwitch;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if( [AppDelegate isValidOSVersionAndPlatform] == YES )
    {
        id userConsentObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"CXA_APP_HAS_USER_CONSENTED_FOR_BEHAVIORAL_DATA_COLLECTION"];
        if( (userConsentObj == nil) || ([userConsentObj boolValue] == NO) )
        {
            [theConsentSwitch setOn:NO];
        }
        else
        {
            [theConsentSwitch setOn:YES];
        }
    }
    else
    {
        [theConsentSwitch setEnabled:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if( segue && ([[segue destinationViewController] class] == [SupportViewController class]) )
    {
        SupportViewController* destinationVC = [segue destinationViewController];
        destinationVC.destinationURL = @"https://acoustic.com/privacy-notice/";
        destinationVC.navigationTitle = @"Privacy Policy";
    }
}
- (IBAction)readPrivacyPolicy:(id)sender {
}
- (IBAction)onOptInOutSwitch:(id)sender {
    UISwitch* switchObj = sender;
    if( switchObj && [switchObj isOn] )
    {
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"CXA_APP_HAS_USER_CONSENTED_FOR_BEHAVIORAL_DATA_COLLECTION"];
        optInOutLabel.text = @"Opt-Out";
        if( [[TLFApplicationHelper sharedInstance] isTLFEnabled] == NO )
        {
            [[TLFApplicationHelper sharedInstance] enableTealeafFramework];
        }
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@NO forKey:@"CXA_APP_HAS_USER_CONSENTED_FOR_BEHAVIORAL_DATA_COLLECTION"];
        optInOutLabel.text = @"Opt-In";
        [[TLFApplicationHelper sharedInstance] disableTealeafFramework];
    }
}

@end
