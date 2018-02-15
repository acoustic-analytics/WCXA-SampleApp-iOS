//
//  Category.h
//  CXA
//
//  Created by Chanikya on 11/3/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <Realm/Realm.h>

@interface Category : RLMObject

@property (nonatomic, assign) NSInteger  categoryId;
@property (nonatomic, strong) NSString   *categoryTitle;
@property (nonatomic, assign) NSInteger  visitedCount;
@property (nonatomic, strong) NSString   *imageThumbnail;

@end
RLM_ARRAY_TYPE(Category)
