//
//  RecentItems.h
//  CXA
//
//  Created by Chanikya on 3/29/17.
//  Copyright (C) 2017 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

#import <Realm/Realm.h>

@interface RecentItems : RLMObject
@property (nonatomic, strong) NSString *recentId;
@property (nonatomic, strong) RLMArray<Item *><Item> *items;
@end
RLM_ARRAY_TYPE(RecentItems)
