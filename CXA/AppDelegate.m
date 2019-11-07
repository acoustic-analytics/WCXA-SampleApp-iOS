//
//  AppDelegate.m
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import "AppDelegate.h"
#import "AppManager.h"
#import "RealmDataController.h"
#import "CXAEnv.h"
#import "RecentItems.h"
#import "Realm/RLMRealm.h"
#import "Item.h"
#import "CXAEnv.h"
#import  <objc/runtime.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)printCookies
{
    for (NSHTTPCookie *theCookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies]) {
        NSString* theCookieName = [theCookie valueForKey:NSHTTPCookieName];
        NSString* theCookieValue = [theCookie valueForKey:NSHTTPCookieValue];
        NSString* theCookieDomain = [theCookie valueForKey:NSHTTPCookieDomain];
        NSLog(@"Name: %@, Value: %@, Domain: %@", theCookieName, theCookieValue, theCookieDomain);
    }
}
-(void)temporaryFixUpForTextLayoutView
{
    if( @available(iOS 13.2, *) )
    {
    }
    else
    {
        const char *className = "_UITextLayoutView";
        Class cls = objc_getClass(className);
        if (cls == nil)
        {
            cls = objc_allocateClassPair([UIView class], className, 0);
            objc_registerClassPair(cls);
        }
    }
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    setenv("EODebug", "1", 1);
    setenv("TLF_DEBUG", "1", 1);
    [self temporaryFixUpForTextLayoutView];
    // Migrates Realm old data if there is a change in Realm data model
    [[RealmDataController sharedInstance] migrateRealmData];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.25 green:0.47 blue:0.75 alpha:1.0]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    // Setting up the data for the app from Realm Database
    RLMResults<Item *> *dataResults = [Item allObjects];
    if (dataResults.count == 0) {
        [[RealmDataController sharedInstance] addDataToRealm];
    }
    
    RLMResults<CXAEnv *> *results = [CXAEnv allObjects];
    if (results.count > 0) {
        [[TLFApplicationHelper sharedInstance] setPostMessageUrl:results[0].postMessageURL];
        [[TLFApplicationHelper sharedInstance] setKillSwitchUrl:results[0].killSwitch];
        [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"AppKey" value:results[0].appKey];
        [[TLFApplicationHelper sharedInstance] setConfigurableItem:@"ibmId" value:results[0].ibmID];
        
        [AppManager sharedInstance].openConfigSession = NO;
    }
    else {
        // use default config from plist
    }
    
    id userConsentObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"CXA_APP_HAS_USER_CONSENTED_FOR_BEHAVIORAL_DATA_COLLECTION"];
    NSLog(@"Inside didFinishLaunchingWithOptions : User Consent from User Defaults : %@", userConsentObj);
    NSLog(@"Inside didFinishLaunchingWithOptions : Printing Cookies");
    [self printCookies];
    if( userConsentObj && ([userConsentObj boolValue] == YES) )
    {
        [[TLFApplicationHelper sharedInstance] enableTealeafFramework];
    }
    
    // Logging custom event for ibmId in each session
    //    if (dict[@"ibmId"]) {
    //        if (![dict[@"ibmId"] isEqualToString:@""]) {
    //            [[TLFCustomEvent sharedInstance] logEvent:@"ibmId" value:dict[@"ibmId"]];
    //        }
    //    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    id userConsentObj = [[NSUserDefaults standardUserDefaults] objectForKey:@"CXA_APP_HAS_USER_CONSENTED_FOR_BEHAVIORAL_DATA_COLLECTION"];
    NSLog(@"Inside applicationWillTerminate : User Consent from User Defaults : %@", userConsentObj);
    NSLog(@"Inside applicationWillTerminate : Printing Cookies");
    [self printCookies];
}


@end
