//
//  NSString+TealeafCryptography.m
//  CXA
//
//  Created by Shridhar Damale on 6/19/20.
//  Copyright © 2020 IBM. All rights reserved.
//

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
