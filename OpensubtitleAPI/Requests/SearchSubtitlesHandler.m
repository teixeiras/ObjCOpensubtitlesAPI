//
//  SearchSubtitlesHandler.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "SearchSubtitlesHandler.h"
#import "Subtitle.h"
@implementation SearchSubtitlesHandler

/**
 @property NSString * token;
 @property NSString * sublanguageid;
 
 @property NSString * moviehash;
 @property NSString * moviebytesize;
 
 @property NSString * imdbid;
 */

-(NSArray *) parameters {
        NSMutableArray * entries = [NSMutableArray new];
    if (self.imdbid) {
        for (NSString * imdbid in self.imdbid) {
            [entries addObject:@{@"sublanguageid":self.sublanguageid,
                                 @"moviehash":@"",
                                 @"moviebytesize":@(0),
                                 @"imdbid":imdbid}];
        }
    }
    if (self.hashList) {
        for (NSDictionary * hash in self.hashList) {
            [entries addObject:@{@"sublanguageid":self.sublanguageid,
                                 @"moviehash":hash[@"moviehash"],
                                 @"moviebytesize":hash[@"moviebytesize"]}];

        }
    }
    return @[self.token,entries];
    
}

-(NSString *) method {
    return @"SearchSubtitles";
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
    if ([response isFault]) {
        NSLog(@"Fault code: %@", [response faultCode]);
        
        NSLog(@"Fault string: %@", [response faultString]);
    } else {
        NSDictionary * responseDic = [response object];
        NSLog(@"Parsed response: %@", [response object]);
        if ([responseDic isKindOfClass:[NSDictionary class]]) {
            NSMutableArray * subtitles = [NSMutableArray new];
            for (NSDictionary * dic in responseDic[@"data"]) {
                Subtitle * sub = [Subtitle new];
                [sub populateWithNSDictionary:dic];
                [subtitles addObject:sub];
            }
            (self.onSubtitlesFound)(YES, subtitles);
        } else {
            NSLog(@"Object parsed is not an nsdictionary");
        }
    }
    (self.onSubtitlesFound)(NO, nil);
}
@end
/*

 struct(
 array(
 struct( subfile ), struct( subfile ), ...
 ) [data],
 (double) [seconds]
 )
 and contains these elements:
 
 data
 array of found subtitle file matches, when no matches are found data is empty.
 subfile
 structure that holds the subtitle file information, see subtitle file structure?
 seconds
*/