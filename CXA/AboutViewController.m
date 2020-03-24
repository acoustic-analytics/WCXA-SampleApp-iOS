//
//  AboutViewController.m
//  CXA
//
//  Created by Chanikya on 4/3/17.
//  Copyright © 2017 IBM. All rights reserved.
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
