//
//  LoginRequest.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "LoginRequest.h"
#import "NSStringAdditions.h"

@implementation LoginRequest

-(NSArray *) parameters {
    return @[@"",@"",@"PT",@"OS Test User Agent"];
}
-(NSString *) method {
    return @"LogIn";
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
            self.token = responseDic[@"token"];
            self.onLogin(YES);
            return;
        } else {
            NSLog(@"Object parsed is not an nsdictionary");
        }
    }
    self.onLogin(NO);
}

@end
