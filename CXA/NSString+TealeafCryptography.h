//
//  NSString+TealeafCryptography.h
//  CXA
//
//  Created by Shridhar Damale on 6/19/20.
//  Copyright © 2020 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TealeafCryptography)
-(NSString*) encryptTealeafData;
-(NSString*) decryptTealeafData;
@end

NS_ASSUME_NONNULL_END
