//
//  NSData+TealeafCryptography.h
//  CXA
//
//  Created by Shridhar Damale on 6/19/20.
//  Copyright © 2020 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (TealeafCryptography)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
