//
//  DownloadSubtitleHandler.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 03/07/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "DownloadSubtitleHandler.h"
#import "SubtitleFileManager.h"

@implementation DownloadSubtitleHandler

-(NSArray *) parameters {
   
    return @[self.token,@[self.subtitleId]];
}

-(NSString *) method {
    return @"DownloadSubtitles";
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
            for (NSDictionary * file in responseDic[@"data"]) {
                //base64-encoded and gzipped subtitle file contents
                NSString * data = file[@"data"];
                NSData * binaryData = [SubtitleFileManager base64DataFromString:data];
                NSString *strData = [[NSString alloc]initWithData:binaryData encoding:NSUTF8StringEncoding];
                NSLog(@"%@", strData);
                
                NSData * unCompressedData = [SubtitleFileManager gunzippedData:unCompressedData];
                strData = [[NSString alloc]initWithData:binaryData encoding:NSUTF8StringEncoding];
                NSLog(@"%@", strData);
                (self.onDownloadSubtitlesSuccessed)(unCompressedData);
                return;
            }
        } else {
            NSLog(@"Object parsed is not an nsdictionary");
        }
        (self.onDownloadSubtitlesFailed)(-1);
    }
}
@end
