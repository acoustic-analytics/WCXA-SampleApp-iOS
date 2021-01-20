//
//  OrderItem.h
//  CXA
//
//  Created by Chanikya on 11/9/16.
//  Copyright (C) 2016 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
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
