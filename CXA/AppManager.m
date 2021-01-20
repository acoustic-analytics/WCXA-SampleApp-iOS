//
//  AppManager.m
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

#import "AppManager.h"
#import "CartItem.h"
#import "RecentItems.h"

@implementation AppManager

+ (instancetype)sharedInstance
{
    static AppManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AppManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self=[super init];
    if (self)
    {
        _anonymousCartItems = [NSMutableArray array];
        _recentlyViewedArray = [NSMutableArray array];
        RLMResults<RecentItems *> *recentItems = [RecentItems allObjects];
        if (recentItems.count > 0) {
            _recentlyViewedArray = [NSMutableArray array];
            for (int k = 0; k < recentItems[0].items.count; k++) {
                [_recentlyViewedArray addObject:[recentItems[0].items objectAtIndex:k]];
            }
        }
    }
    return self;
}

- (NSAttributedString *)starRatingWith:(NSInteger)filledStars
                            outOfTotal:(NSInteger)totalStars {
    UIFont *fontAwesome = [UIFont fontWithName:@"FontAwesome" size:18.0f];
    NSDictionary *activeStarFormatting = @{
                                           NSFontAttributeName : fontAwesome,
                                           NSForegroundColorAttributeName : [UIColor colorWithRed:1.00 green:0.80 blue:0.40 alpha:1.0]
                                           };
    NSDictionary *inactiveStarFormatting = @{
                                             NSFontAttributeName : fontAwesome,
                                             NSForegroundColorAttributeName : [UIColor lightGrayColor]
                                             };
    
    NSMutableAttributedString *attString = [NSMutableAttributedString new];
    
    NSInteger i = 0;
    for (; i < filledStars; ++i) {
        [attString appendAttributedString:[[NSAttributedString alloc]
                                           initWithString:@" \uf005 " attributes:activeStarFormatting]];
    }
    for (; i < totalStars; ++i) {
        [attString appendAttributedString:[[NSAttributedString alloc]
                                           initWithString:@" \uf005 " attributes:inactiveStarFormatting]];
    }
    
    return attString;
}

- (UIImage *) scaleImage:(UIImage *) image
{
    CGSize size = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.6, 0.6));
    BOOL hasAlpha = NO;
    CGFloat scale = 0.0;  // Automatically use scale factor of main screen
    
    UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

- (void) addItemToCart:(Item *) item
{
    if (!self.userId) {
        BOOL isItemInList = NO;
        for (CartItem *ct in [AppManager sharedInstance].anonymousCartItems) {
            if (ct.itemId == item.itemId) {
                ct.quantity = ct.quantity + 1;
                isItemInList = YES;
            }
        }
        
        if (!isItemInList) {
            CartItem *cartItem = [[CartItem alloc] init];
            cartItem.itemId = item.itemId;
            cartItem.quantity = 1;
            cartItem.price = item.price;
            [[AppManager sharedInstance].anonymousCartItems addObject:cartItem];
        }
    }
    else {
        CartItem *cartItem = [[CartItem alloc] init];
        cartItem.itemId = item.itemId;
        cartItem.userId = [AppManager sharedInstance].userId;
        cartItem.price = item.price;
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"itemId = %d AND userId = %@", cartItem.itemId, [AppManager sharedInstance].userId];
        RLMResults<CartItem *> *result = [CartItem objectsWithPredicate:pred];
        if (result.count > 0) {
            CartItem *it = result[0];    // make sure same CartItem is never added twice for same user.. Instead just update quantity..
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                it.quantity = it.quantity + 1;
            }];
        }
        else {
            cartItem.quantity = 1;
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject:cartItem];
            }];
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CartItemUpdated" object:self];
}

- (void) updateCartItem:(Item *) item withQuantity:(NSInteger) value
{
    if (!self.userId) {
        for (CartItem *ct in [AppManager sharedInstance].anonymousCartItems) {
            if (ct.itemId == item.itemId) {
                ct.quantity = value;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CartItemUpdated" object:self];
            }
        }
    }
    else {
        CartItem *cartItem = [[CartItem alloc] init];
        cartItem.itemId = item.itemId;
        cartItem.userId = [AppManager sharedInstance].userId;
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"itemId = %d AND userId = %@", cartItem.itemId, [AppManager sharedInstance].userId];
        RLMResults<CartItem *> *result = [CartItem objectsWithPredicate:pred];
        for (CartItem *it in result) {
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                it.quantity = value;
                dispatch_async(dispatch_get_main_queue(),^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"CartItemUpdated" object:self];
                });
            }];
        }
    }
}

- (void) saveRecentlyVisitedItem:(Item *) item
{
    RecentItems *recentItems = [[RecentItems alloc] init];
    RLMArray<Item *><Item> *tempArr = (RLMArray <Item> *) [[RLMArray alloc] initWithObjectClassName:@"Item"];
    RLMResults<RecentItems *> *results = [RecentItems allObjects];
    BOOL canAddItem = YES;
    
    if (results.count > 0) {
        for (int k = 0; k < results[0].items.count; k++) {
            if (results[0].items[k].itemId == item.itemId) {
                canAddItem = NO;
                break;
            }
        }
    }
    
    if (canAddItem) {
        int isThreeItemsSaved = 0;
        [self.recentlyViewedArray addObject:item];
        for (int i = (int) self.recentlyViewedArray.count - 1; i >=0; --i) {
            isThreeItemsSaved = isThreeItemsSaved + 1;
            if (isThreeItemsSaved > 3) {
                break;
            }
            [tempArr addObject:self.recentlyViewedArray[i]];
        }
        recentItems.items = tempArr;
        recentItems.recentId = @"1";
    
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:recentItems];
        [realm commitWriteTransaction];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RecentListUpdated" object:self];
    }
}

- (NSArray *) getMostRecent {
    NSMutableArray *tempArr = [NSMutableArray array];
    RLMResults<RecentItems *> *results = [RecentItems allObjects];
    if(results.count > 0) {
        for (int i = 0; i < results[0].items.count; i++) {
            [tempArr addObject:[results[0].items objectAtIndex:i]];
        }
    }
//    int isThreeItemsSaved = 0;
//    for (int i = (int) self.recentlyViewedArray.count - 1; i >=0; --i) {
//        isThreeItemsSaved = isThreeItemsSaved + 1;
//        if (isThreeItemsSaved > 3) {
//            break;
//        }
//        [tempArr addObject:self.recentlyViewedArray[i]];
//    }
    return tempArr;
}

- (void) incrementCategoryVisitedCount:(Category *) catog {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    catog.visitedCount = catog.visitedCount + 1;
    [realm addOrUpdateObject:catog];
    [realm commitWriteTransaction];
}

@end
