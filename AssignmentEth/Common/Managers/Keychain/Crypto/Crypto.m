//
//  Crypto.m
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

#import "Crypto.h"

@implementation Crypto

+(NSData*)applyXOR:(NSData*)data forHash:(NSString*)hash; {
    // Get pointer to data to obfuscate
    char *dataPtr = (char *) [data bytes];
    // Get pointer to key data
    char *keyData = (char *) [[hash dataUsingEncoding:NSUTF8StringEncoding] bytes];
    // Points to each char in sequence in the key
    char *keyPtr = keyData;
    int keyIndex = 0;
    // For each character in data, xor with current value in key
    for (int x = 0; x < [data length]; x++){
        // Replace current character in data with
        // current character xor'd with current key value.
        // Bump each pointer to the next character
        char csp[2] = {*dataPtr, 0};
        NSString *sp = [[NSString alloc] initWithCString:csp encoding: NSUTF8StringEncoding];
        if (sp) {
            *dataPtr = *dataPtr ^ *keyPtr;
        } else {
            //nothing, keep not encrypted because xored returns not valid char in uft8
        }
        //*dataPtr = *dataPtr ^ *keyPtr;
        dataPtr++;
        keyPtr++;
        // If at end of key data, reset count and
        // set key pointer back to start of key value
        if (++keyIndex == [hash length]){
            keyIndex = 0;
            keyPtr = keyData;
        }
    }
    return data;
}

@end
