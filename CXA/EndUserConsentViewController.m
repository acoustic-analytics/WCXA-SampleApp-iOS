//
//  EndUserConsentViewController.m
//  CXA
//
//  Created by Shridhar Damale on 2/12/19.
//  Copyright © 2019 IBM. All rights reserved.
//

#import "EndUserConsentViewController.h"
#import "SupportViewController.h"

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if( segue && ([[segue destinationViewController] class] == [SupportViewController class]) )
    {
        SupportViewController* destinationVC = [segue destinationViewController];
        destinationVC.destinationURL = @"https://www.ibm.com/support/knowledgecenter/en/SS2MBL_9.0.2/Installation/CX/InstOverview/HowDataPrivacyWorks.html";
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
