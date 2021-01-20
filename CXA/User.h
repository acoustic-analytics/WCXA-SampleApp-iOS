//
//  User.h
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

#import "Realm/RLMObject.h"
#import "Realm/RLMArray.h"
#import "Item.h"
#import "Order.h"

@interface User : RLMObject

@property (nonatomic, strong) NSString                  *firstName;
@property (nonatomic, strong) NSString                  *lastName;
@property (nonatomic, strong) NSString                  *email;
@property (nonatomic, strong) NSString                  *password;
@property (nonatomic, assign) NSInteger                 age;
@property (nonatomic, strong) NSString                  *address;
@property (nonatomic, strong) NSString                  *userId;

@end
