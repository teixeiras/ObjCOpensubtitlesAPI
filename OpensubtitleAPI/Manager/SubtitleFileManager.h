//
//  SubtitleFileManager.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 03/07/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubtitleFileManager : NSObject
+(NSData *)gunzippedData:(NSData *) gzipdata;
+ (NSData *)base64DataFromString: (NSString *)string;

@end
