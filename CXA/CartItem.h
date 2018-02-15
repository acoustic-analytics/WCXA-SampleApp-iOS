//
//  CartItem.h
//  CXA
//
//  Created by Chanikya on 11/1/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <Realm/Realm.h>

@interface CartItem : RLMObject

@property (nonatomic, assign) NSInteger  itemId;
@property (nonatomic, strong) NSString   *userId;
@property (nonatomic, assign) double     price;
@property (nonatomic, assign) NSInteger  quantity;

@end
RLM_ARRAY_TYPE(CartItem)
