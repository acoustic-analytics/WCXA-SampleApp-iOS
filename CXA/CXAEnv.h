//
//  CXAEnv.h
//  CXA
//
//  Created by Chanikya on 1/24/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import <Realm/Realm.h>

@interface CXAEnv : RLMObject

@property (nonatomic, strong) NSString  *dummyId;
@property (nonatomic, strong) NSString  *acoID;
@property (nonatomic, strong) NSString  *appKey;
@property (nonatomic, strong) NSString  *postMessageURL;
@property (nonatomic, strong) NSString  *killSwitch;

@end
