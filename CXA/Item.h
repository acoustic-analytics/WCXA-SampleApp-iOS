//
//  Item.h
//  CXA
//
//  Created by Chanikya on 10/31/16.
//  Copyright © 2016 IBM. All rights reserved.
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
