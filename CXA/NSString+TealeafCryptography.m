//
//  NSString+TealeafCryptography.m
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


#import "NSString+TealeafCryptography.h"
#import "NSData+TealeafCryptography.h"
NSString *key = @""; //@"<please enter 32 byte long key here. For example: 0123456789abcdef>";
@implementation NSString (TealeafCryptography)
-(NSString*) encryptTealeafData
{
    NSString* encryptedString = self;
    if( (key != nil) && ([key length] > 0) && ([self length] > 0) )
    {
        NSData *orgStringData = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSData *encryptedData = [orgStringData AES256EncryptWithKey:key];
        encryptedString = [encryptedData base64EncodedStringWithOptions:0];
    }
    return encryptedString;
}
-(NSString*) decryptTealeafData
{
    NSString* decryptedString = self;
    if( (key != nil) && ([key length] > 0) && ([self length] > 0) )
    {
        NSData *encryptedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
        NSData *orgStringData = [encryptedData AES256DecryptWithKey:key];
        decryptedString = [[NSString alloc] initWithData:orgStringData encoding:NSUTF8StringEncoding];
    }
    return decryptedString;
}
@end
