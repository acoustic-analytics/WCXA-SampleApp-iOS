//
//  AppManager.h
//  CXA
//
//  Created by Chanikya on 10/27/16.
//  Copyright © 2016 IBM. All rights reserved.
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
