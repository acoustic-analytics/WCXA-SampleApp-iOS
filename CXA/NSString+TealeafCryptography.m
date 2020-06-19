//
//  NSString+TealeafCryptography.m
//  CXA
//
//  Created by Shridhar Damale on 6/19/20.
//  Copyright © 2020 IBM. All rights reserved.
//

/*
This file is provided as sample only. You should implement your own categories to NSData and NSString for encryption-decryption as per your security policy. You do not have to have these methods or categories. This is optional. If these methods are implemented in your application, Tealeaf SDK  would call these APIs before saving data to local storage. If you choose to implement these; please test the methods properly; make sure there is a faithful encryption and decryption of the JSON string passed in. SDK relies on your application's NSString ecryption decryption methods. SDK itself does not encrypt, decrypt or validate if these operations are successful. Hence carefully implement and test.
*/


#import "NSString+TealeafCryptography.h"
#import "NSData+TealeafCryptography.h"
NSString *key = @""; //@"<please enter 32 byte long key here>";
@implementation NSString (TealeafCryptography)
-(NSString*) encryptTealeafData
{
    NSString* encryptedString = self;
    if( (key != nil) && ([key length] > 0) && ([self length] > 0) )
    {
        NSData *orgStringData = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSData *encryptedData = [orgStringData AES256EncryptWithKey:key];
        encryptedString = [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
    }
    return encryptedString;
}
-(NSString*) decryptTealeafData
{
    NSString* decryptedString = self;
    if( (key != nil) && ([key length] > 0) && ([self length] > 0) )
    {
        NSData *encryptedData = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSData *orgStringData = [encryptedData AES256DecryptWithKey:key];
        decryptedString = [[NSString alloc] initWithData:orgStringData encoding:NSUTF8StringEncoding];
    }
    return decryptedString;
}
@end
