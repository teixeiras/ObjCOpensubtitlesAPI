//
//  OSHashAlgorithm.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
    uint64_t fileHash;
    uint64_t fileSize;
} VideoHash;

@interface OSHashAlgorithm : NSObject {
    
}
+(VideoHash)hashForPath:(NSString*)path;
+(VideoHash)hashForURL:(NSURL*)url;
+(VideoHash)hashForFile:(NSFileHandle*)handle;
+(NSString*)stringForHash:(uint64_t)hash;

@end
