//
//  Crypto.h
//  AssignmentEth
//
//  Created by Iglesias, Gustavo on 17/01/2020.
//  Copyright © 2020 ttg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Crypto : NSObject
+(NSData*)applyXOR:(NSData*)data forHash:(NSString*)hash;
@end

NS_ASSUME_NONNULL_END
