//
//  OrderItem.h
//  CXA
//
//  Created by Chanikya on 11/9/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <Realm/Realm.h>

@interface OrderItem : RLMObject
@property (nonatomic, assign) NSInteger  itemId;
@property (nonatomic, strong) NSString   *userId;
@property (nonatomic, assign) double     price;
@property (nonatomic, assign) NSInteger  quantity;
@property (nonatomic, strong) NSDate     *orderDate;

@end
RLM_ARRAY_TYPE(OrderItem)
