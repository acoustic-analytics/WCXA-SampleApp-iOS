//
//  SupportViewController.m
//  CXA
//
//  Created by Chanikya on 4/4/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
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
    
    NSString *fullURL = @"https://acoustic.com/products/experience-analytics/";
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
