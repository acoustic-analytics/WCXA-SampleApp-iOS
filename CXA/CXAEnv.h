//
//  CXAEnv.h
//  CXA
//
//  Created by Chanikya on 1/24/17.
//  Copyright © 2017 IBM. All rights reserved.
//

#import <Realm/Realm.h>

@interface CXAEnv : RLMObject

@property (nonatomic, strong) NSString  *dummyId;
@property (nonatomic, strong) NSString  *ibmID;
@property (nonatomic, strong) NSString  *appKey;
@property (nonatomic, strong) NSString  *postMessageURL;
@property (nonatomic, strong) NSString  *killSwitch;

@end
