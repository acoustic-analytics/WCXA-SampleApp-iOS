//
//  User.h
//  CXA
//
//  Created by Chanikya on 11/1/16.
//  Copyright © 2016 IBM. All rights reserved.
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
