//
//  Item.h
//  CXA
//
//  Created by Chanikya on 10/31/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import "Realm/RLMObject.h"

@interface Item : RLMObject

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, assign) NSInteger listId;
@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *owner;
@property (nonatomic, assign) NSInteger rating;
@property (nonatomic, assign) NSInteger ratingCount;
@property (nonatomic, strong) NSString  *image;
@property (nonatomic, strong) NSString  *thumbnail;
@property (nonatomic, strong) NSString  *fullDescription;
@property (nonatomic, strong) NSString  *shortDescription;
@property (nonatomic, assign) double    price;
@property (nonatomic, strong) NSString  *stockAvailability;

@end
RLM_ARRAY_TYPE(Item)
