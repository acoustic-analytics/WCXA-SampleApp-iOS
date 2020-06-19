//
//  NSData+TealeafCryptography.m
//  CXA
//
//  Created by Shridhar Damale on 6/19/20.
//  Copyright © 2020 IBM. All rights reserved.
//

#import "NSData+TealeafCryptography.h"
#import <CommonCrypto/CommonCryptor.h>
@implementation NSData (TealeafCryptography)
- (NSData *)AES256EncryptWithKey:(NSString *)key
{
    NSData* encryptedData = nil;
    char keyStr[kCCKeySizeAES256+1];
    bzero(keyStr, sizeof(keyStr));
    [key getCString:keyStr maxLength:sizeof(keyStr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLen = [self length];
    size_t dataOutLen = dataLen + kCCBlockSizeAES128;
    void *dataOut = malloc(dataOutLen);
    size_t encryptedDataSize = 0;
    CCCryptorStatus encryptionStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyStr, kCCKeySizeAES256, NULL, [self bytes], dataLen, dataOut, dataOutLen, &encryptedDataSize);
    if( encryptionStatus == kCCSuccess )
    {
        encryptedData = [NSData dataWithBytesNoCopy:dataOut length:encryptedDataSize];
    }
    free(dataOut);
    return encryptedData;
}
- (NSData *)AES256DecryptWithKey:(NSString *)key
{
    NSData* decryptedData = nil;
    char keyStr[kCCKeySizeAES256+1];
    bzero(keyStr, sizeof(keyStr));
    [key getCString:keyStr maxLength:sizeof(keyStr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLen = [self length];
    size_t dataOutLen = dataLen + kCCBlockSizeAES128;
    void *dataOut = malloc(dataOutLen);
    size_t decryptedDataSize = 0;
    CCCryptorStatus decryptionStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyStr, kCCKeySizeAES256, NULL, [self bytes], dataLen, dataOut, dataOutLen, &decryptedDataSize);
    if( decryptionStatus == kCCSuccess )
    {
        decryptedData = [NSData dataWithBytesNoCopy:dataOut length:decryptedDataSize];
    }
    free(dataOut);
    return decryptedData;
}
@end
