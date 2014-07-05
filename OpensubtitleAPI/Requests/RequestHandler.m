//
//  RequestHandler.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "RequestHandler.h"
#import "XMLRPCRequest.h"
#import "XMLRPCResponse.h"
#import "XMLRPCConnectionManager.h"
#import "RequestErrorHandler.h"
#import "OSubManager.h"

@interface RequestHandler()<XMLRPCConnectionDelegate>
@end

@implementation RequestHandler
-(NSURL *) url {
    return [NSURL URLWithString: @"http://api.opensubtitles.org/xml-rpc"];
}

-(NSArray *) parameters {
    return @[];
}

-(NSString *) method {
    return @"";
}

-(void) makeRequest{
    
    XMLRPCRequest *request = [[XMLRPCRequest alloc] initWithURL: [self url]];
    XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];
    
    [request setMethod: [self method] withParameters: [self parameters]];
    
    NSLog(@"Request body: %@", [request body]);
    
    [manager spawnConnectionWithXMLRPCRequest: request delegate: self];

}

-(void) request:(XMLRPCRequest *)request didFailWithError:(NSError *)error {
    
}

-(void) request:(XMLRPCRequest *)request didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
}

-(void) request:(XMLRPCRequest *)request didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
}

- (BOOL)request: (XMLRPCRequest *)request canAuthenticateAgainstProtectionSpace: (NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
    if ([response isFault]) {
        NSLog(@"Fault code: %@", [response faultCode]);
        
        NSLog(@"Fault string: %@", [response faultString]);
    } else {
        NSLog(@"Parsed response: %@", [response object]);
    }
    
    NSLog(@"Response body: %@", [response body]);
}


-(BOOL) reloadTokenIfNecessaryForRequest:(NSDictionary *)responseDic onfinish:(void(^)()) renewCallback{
    if ([[RequestErrorHandler sharedInstance] hasErrorOccurredWithMessage:responseDic[@"status"] onMessageFind:^(BOOL failed, NSNumber * errorCode, NSString * messsage) {
        if (failed) {
            if ([errorCode isEqualToNumber:@(401)]) {
                [[OSubManager sharedObject] reloadSessionOnResponse:^(BOOL success) {
                    if (success) {
                        self.token = [OSubManager sharedObject].token;
                        [self makeRequest];
                        return;
                    }
                }];
            }
        }
    }]) {
        return YES;
    }
    (renewCallback)();
    return NO;
}
@end
