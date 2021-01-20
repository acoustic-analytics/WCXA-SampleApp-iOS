//
//  Order.h
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
