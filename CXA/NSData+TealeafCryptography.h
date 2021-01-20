//
//  NSData+TealeafCryptography.h
//  CXA
//
//  Created by Shridhar Damale on 6/19/20.
//  Copyright (C) 2020 Acoustic, L.P. All rights reserved.
//
//  NOTICE: This file contains material that is confidential and proprietary to
//  Acoustic, L.P. and/or other developers. No license is granted under any intellectual or
//  industrial property rights of Acoustic, L.P. except as may be provided in an agreement with
//  Acoustic, L.P. Any unauthorized copying or distribution of content from this file is
//  prohibited.
//

/*
This file is provided as sample only. You should implement your own categories to NSData and NSString for encryption-decryption as per your security policy. You do not have to have these methods or categories. This is optional. If these methods are implemented in your application, Tealeaf SDK  would call these APIs before saving data to local storage. If you choose to implement these; please test the methods properly; make sure there is a faithful encryption and decryption of the JSON string passed in. SDK relies on your application's NSString ecryption decryption methods. SDK itself does not encrypt, decrypt or validate if these operations are successful. Hence carefully implement and test.
*/


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (TealeafCryptography)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
