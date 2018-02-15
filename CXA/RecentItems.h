//
//  RecentItems.h
//  CXA
//
//  Created by Chanikya on 3/29/17.
//  Copyright © 2017 IBM. All rights reserved.
//

#import <Realm/Realm.h>

@interface RecentItems : RLMObject
@property (nonatomic, strong) NSString *recentId;
@property (nonatomic, strong) RLMArray<Item *><Item> *items;
@end
RLM_ARRAY_TYPE(RecentItems)
