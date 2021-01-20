//
//  AppManager.h
//  CXA
//
//  Created by Chanikya on 10/27/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "Category.h"

@interface AppManager : NSObject

@property (nonatomic, strong) NSString   *userId;
@property (nonatomic, assign) BOOL       isDefaultRealmDataSaved;
@property (nonatomic, strong) NSMutableArray *anonymousCartItems;
@property (nonatomic, assign) BOOL       isLoginSkipped;
@property (nonatomic, strong) UITabBarController *currentTabController;
@property (nonatomic, assign) BOOL       skipAccountVCLogging;
@property (nonatomic, strong) NSMutableArray *recentlyViewedArray;
@property (nonatomic, assign) BOOL       openConfigSession;


+ (instancetype)sharedInstance;
- (void) addItemToCart:(Item *) item;
- (UIImage *) scaleImage:(UIImage *) image;
- (void) updateCartItem:(Item *) item withQuantity:(NSInteger) value;
- (NSAttributedString *)starRatingWith:(NSInteger)filledStars outOfTotal:(NSInteger)totalStars;
- (void) saveRecentlyVisitedItem:(Item *) item;
- (NSArray *) getMostRecent;
- (void) incrementCategoryVisitedCount:(Category *) catog;
@end
