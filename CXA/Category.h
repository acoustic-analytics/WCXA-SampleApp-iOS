//
//  Category.h
//  CXA
//
//  Created by Chanikya on 11/3/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import <Realm/Realm.h>

@interface Category : RLMObject

@property (nonatomic, assign) NSInteger  categoryId;
@property (nonatomic, strong) NSString   *categoryTitle;
@property (nonatomic, assign) NSInteger  visitedCount;
@property (nonatomic, strong) NSString   *imageThumbnail;

@end
RLM_ARRAY_TYPE(Category)
