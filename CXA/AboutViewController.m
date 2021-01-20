//
//  AboutViewController.m
//  CXA
//
//  Created by Chanikya on 4/3/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"About CXA";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)logAllConnections:(id)sender {
    @try
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self logConnectionGood];
        });
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self logConnectionBad];
        });
    }
    @catch (NSException *exception)
    {
        
    }
}
-(void)logConnectionGood
{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.acoustic.co"]];
    NSURLSession *sharedSyncSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [sharedSyncSession dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSLog(@"Logged GET good message");
                                  
    }];
    
    [task resume];
}
-(void)logConnectionBad
{
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.theserverthatdoesnotexistandwillneverexist.com"]];
    NSURLSession *sharedSyncSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [sharedSyncSession dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSLog(@"Logged GET bad   message");
                                  
    }];
    
    [task resume];
}
@end
