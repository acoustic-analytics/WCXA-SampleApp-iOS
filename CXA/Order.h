//
//  Order.h
//  CXA
//
//  Created by Chanikya on 11/1/16.
//  Copyright © 2016 IBM. All rights reserved.
//

#import <Realm/Realm.h>
#import "OrderItem.h"

@interface Order : RLMObject

@property (nonatomic, strong) NSString  *orderId;
@property (nonatomic, strong) RLMArray<OrderItem *><OrderItem> *items;
@property (nonatomic, strong) NSString  *userId;
@property (nonatomic, strong) NSString  *customerCity;
@property (nonatomic, strong) NSString  *customerState;
@property (nonatomic, strong) NSString  *customerZip;
@property (nonatomic, assign) double    subTotal;

@end
RLM_ARRAY_TYPE(Order)
