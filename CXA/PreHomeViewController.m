//
//  PreHomeViewController.m
//  CXA
//
//  Created by Chanikya on 6/5/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "PreHomeViewController.h"
#import "CXAEnvViewController.h"
#import "CXAEnv.h"
#import "AppDelegate.h"

@interface PreHomeViewController () <UIPageViewControllerDataSource>
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (atomic, strong)    NSArray              *tutorialPages;
@end

@implementation PreHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*Print document dir*/
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        if( documentsDirectory )
        {
            NSLog(@"Cached files : %@", documentsDirectory);
        }
    }
    
    self.tryCXAOutlet.layer.cornerRadius = 5;
    self.tryCXAOutlet.layer.shadowOffset = CGSizeMake(3, 3);
    self.configBtnOutlet.layer.cornerRadius = 5;
    self.configBtnOutlet.layer.shadowOffset = CGSizeMake(3, 3);
    self.startBtnOutlet.layer.cornerRadius = 5;
    self.startBtnOutlet.layer.shadowOffset = CGSizeMake(3, 3);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    UIViewController *page1 = [storyboard instantiateViewControllerWithIdentifier:@"TutorialScreen1"];
    UIViewController *page2 = [storyboard instantiateViewControllerWithIdentifier:@"TutorialScreen2"];
    UIViewController *page3 = [storyboard instantiateViewControllerWithIdentifier:@"TutorialScreen3"];
    self.tutorialPages = [NSArray arrayWithObjects:page1,page2,page3,nil];
    
    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"isAppOpenedFirstTime"] boolValue]) {
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isAppOpenedFirstTime"];
        
        //[self showPageControllerTutorial];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isAppOpenedFirstTime"] boolValue]) {
        [self performSegueWithIdentifier:@"startSessionSegue" sender:self];
    }
    else if ([AppManager sharedInstance].openConfigSession) {
        [self performSegueWithIdentifier:@"startSessionSegue" sender:self];
    }
}

- (IBAction)startDefaultConfig:(id)sender {
    [self setDefaultConfig];
    if( [AppDelegate isValidOSVersionAndPlatform] == YES )
    {
        [[TLFApplicationHelper sharedInstance] enableTealeafFramework];
    }
    [self performSegueWithIdentifier:@"startSessionSegue" sender:self];
}

- (IBAction)configureEnv:(id)sender {
    [self performSegueWithIdentifier:@"configSegue" sender:self];
}

- (IBAction)startNewSession:(id)sender {
    RLMResults<CXAEnv *> *results = [CXAEnv allObjects];
    if (results.count > 0) {
        [[TLFApplicationHelper sharedInstance] setPostMessageUrl:results[0].postMessageURL];
        [[TLFApplicationHelper sharedInstance] setKillSwitchUrl:results[0].killSwitch];
        [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"AppKey" value:results[0].appKey];
        [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"acoId" value:results[0].acoID];
        
        [AppManager sharedInstance].openConfigSession = NO;
    }
    else {
        [self setDefaultConfig];
    }
    if( [AppDelegate isValidOSVersionAndPlatform] == YES )
    {
        [[TLFApplicationHelper sharedInstance] enableTealeafFramework];
    }
    [self performSegueWithIdentifier:@"startSessionSegue" sender:self];
}

- (void) setDefaultConfig {
    NSString *mainPath = [[NSBundle mainBundle] pathForResource:@"TLFResources" ofType:@"bundle"];
    NSBundle *bundlePath = [[NSBundle alloc] initWithPath:mainPath];
    NSString *filePath = [bundlePath pathForResource:@"TealeafBasicConfig" ofType:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    [[TLFApplicationHelper sharedInstance] setPostMessageUrl:dict[@"PostMessageUrl"]];
    [[TLFApplicationHelper sharedInstance] setKillSwitchUrl:dict[@"KillSwitchUrl"]];
    [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"AppKey" value:dict[@"AppKey"]];
    [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"acoId" value:dict[@"acoId"]];
    
    [AppManager sharedInstance].openConfigSession = NO;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.tutorialPages indexOfObject:viewController];  //((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.tutorialPages indexOfObject:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == 3) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}
- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (index >= 3) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    UIViewController *pageContentViewController = self.tutorialPages[index];
    return pageContentViewController;
}
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 3;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
- (void) showPageControllerTutorial {
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TutorialPageController"];
    self.pageViewController.dataSource = self;
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self presentViewController:self.pageViewController animated:NO completion:nil];
}

@end
