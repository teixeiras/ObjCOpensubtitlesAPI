//
//  SearchMoviesOnIMDBHandler.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "SearchMoviesOnIMDBHandler.h"
#import "RequestErrorHandler.h"
#import "OSubManager.h"
@implementation SearchMoviesOnIMDBHandler

-(NSArray *) parameters {
    return @[self.token, self.query];
}
-(NSString *) method {
    return @"SearchMoviesOnIMDB";
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
        
        self.onMoviesFound(NO,nil);
    } else {
        
        NSDictionary * responseDic = [response object];
        [self reloadTokenIfNecessaryForRequest:responseDic onfinish:^{
            NSLog(@"Parsed response: %@", [response object]);
            
            if ([responseDic isKindOfClass:[NSDictionary class]]) {
                NSArray * data = responseDic[@"data"];
                if (data.count) {
                    self.onMoviesFound(YES,data);
                    return;
                }

            } else {
                NSLog(@"Object parsed is not an nsdictionary");
            }
            self.onMoviesFound(NO,nil);
        }];
    }
}
@end
