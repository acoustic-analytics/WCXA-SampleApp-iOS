//
//  RealmDataController.h
//  CXA
//
//  Created by Chanikya on 11/1/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RealmDataController : NSObject

+ (instancetype)sharedInstance;
- (void) addDataToRealm;
- (void) addItemWithitemId:(NSInteger) id title:(NSString *) name owner:(NSString *) owner rating:(NSInteger) rating ratingCount:(NSInteger) rateCount shortDescription:(NSString *) shortDesc price:(NSInteger) price stock:(NSString *) availability image:(NSString *) imageName thumbnail:(NSString *) thumbnail categoryId:(NSInteger) categoryId;

- (void) addCategoryDataToRealmWithCategoryId:(NSInteger) categoryId categoryTitle: (NSString *) categoryTitle;
- (void) migrateRealmData;

@end
