//
//  TopCategories.h
//  CXA
//
//  Created by Chanikya on 3/31/17.
//  Copyright © 2017 IBM. All rights reserved.
//

#import <Realm/Realm.h>
#import "Category.h"

@interface TopCategories : RLMObject
@property (nonatomic, strong) NSString *categoriesId;
@property (nonatomic, strong) RLMArray<Category *><Category> *categories;
@end
RLM_ARRAY_TYPE(TopCategories)
