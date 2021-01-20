//
//  RealmDataController.h
//  CXA
//
//  Created by Chanikya on 11/1/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import <Foundation/Foundation.h>

@interface RealmDataController : NSObject

+ (instancetype)sharedInstance;
- (void) addDataToRealm;
- (void) addItemWithitemId:(NSInteger) id title:(NSString *) name owner:(NSString *) owner rating:(NSInteger) rating ratingCount:(NSInteger) rateCount shortDescription:(NSString *) shortDesc price:(NSInteger) price stock:(NSString *) availability image:(NSString *) imageName thumbnail:(NSString *) thumbnail categoryId:(NSInteger) categoryId;
- (void) addCategoryDataToRealmWithCategoryId:(NSInteger) categoryId andCategoryTitle: (NSString *) categoryTitle andImage:(NSString *) image;
- (void) migrateRealmData;

@end
