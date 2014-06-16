//
//  OSHashAlgorithm.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "OSHashAlgorithm.h"

#import "OSHashAlgorithm.h"


@implementation OSHashAlgorithm

+(NSString*)stringForHash:(uint64_t)hash
{
    return [NSString stringWithFormat:@"%qx", hash ];
}
+(VideoHash)hashForPath:(NSString*)path
{
    VideoHash hash;
    hash.fileHash =0;
    hash.fileSize =0;
    
    NSFileHandle *readFile = [NSFileHandle fileHandleForReadingAtPath:path];
    hash = [OSHashAlgorithm hashForFile:readFile];
    [readFile closeFile];
    return hash;
}
+(VideoHash)hashForURL:(NSURL*)url
{
    VideoHash hash;
    hash.fileHash =0;
    hash.fileSize =0;
    
    NSFileHandle *readfile = [NSFileHandle fileHandleForReadingFromURL:url error:NULL];
    hash = [OSHashAlgorithm hashForFile:readfile];
    return hash;
}

+(VideoHash)hashForFile:(NSFileHandle*)handle
{
    VideoHash retHash;
    retHash.fileHash =0;
    retHash.fileSize =0;
    
    if( handle == nil )
        return retHash;
    
    const NSUInteger CHUNK_SIZE=65536;
    NSData *fileDataBegin, *fileDataEnd;
    uint64_t hash=0;
    
    
    fileDataBegin = [handle readDataOfLength:(NSUInteger)CHUNK_SIZE];
    [handle seekToEndOfFile];
    unsigned long long fileSize = [handle offsetInFile];
    if(fileSize < CHUNK_SIZE )
        return retHash;
    
    [handle seekToFileOffset:MAX(0,fileSize-CHUNK_SIZE) ];
    fileDataEnd = [handle readDataOfLength:(NSUInteger)CHUNK_SIZE];
    
    //
    // Calculate hash
    //
    
    // 1st. File size
    hash += fileSize;
    // 2nd. Begining data block
    uint64_t * data_bytes= (uint64_t*)[fileDataBegin bytes];
    for( int i=0; i< CHUNK_SIZE/sizeof(uint64_t); i++ )
        hash+=data_bytes[i];;
    // 3rd. Ending data block
    data_bytes= (uint64_t*)[fileDataEnd bytes];
    for( int i=0; i< CHUNK_SIZE/sizeof(uint64_t); i++ )
        hash+= data_bytes[i];
    
    retHash.fileHash = hash;
    retHash.fileSize = fileSize;
    
    return retHash;
    
}

@end