//
//  main.m
//  CXA
//
//  Created by Chanikya on 10/20/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *tealeafSDK = NSStringFromClass([TLFApplication class]);
        return UIApplicationMain(argc, argv, tealeafSDK, NSStringFromClass([AppDelegate
                                                                            class]));
        
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
