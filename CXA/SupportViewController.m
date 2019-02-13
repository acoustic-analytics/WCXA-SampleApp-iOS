//
//  SupportViewController.m
//  CXA
//
//  Created by Chanikya on 4/4/17.
//  Copyright © 2017 IBM. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIActivityIndicatorView *activityView;
@end

@implementation SupportViewController
@synthesize destinationURL;
@synthesize navigationTitle;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Support";
    if( navigationTitle && [navigationTitle length] > 0 )
    {
        self.navigationItem.title = navigationTitle;
    }
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    self.activityView = [[UIActivityIndicatorView alloc]
                                             initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center=self.view.center;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
    
    NSString *fullURL = @"https://www.ibm.com/communities/analytics/customer-experience-analytics/";
    if( destinationURL && [destinationURL length] > 0 )
    {
        fullURL = destinationURL;
    }
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView stopAnimating];
}
@end
