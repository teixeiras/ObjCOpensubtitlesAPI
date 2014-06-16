//
//  GetSubLanguagesHandler.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "GetSubLanguagesHandler.h"

@implementation GetSubLanguagesHandler

-(NSArray *) parameters {
    return @[self.language];
}
-(NSString *) method {
    return @"GetSubLanguages";
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
            if (responseDic[@"data"]) {
                self.onLanguageRetrieve(YES, responseDic[@"data"]);
                return;
            }
            
        } else {
            NSLog(@"Object parsed is not an nsdictionary");
        }
    }
    self.onLanguageRetrieve(NO, nil);
    return;
}


@end
