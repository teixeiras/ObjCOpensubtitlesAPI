//
//  RequestHandler.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLRPCRequest.h"
#import "XMLRPCResponse.h"
#import "XMLRPCConnectionManager.h"

@interface RequestHandler : NSObject


-(NSURL *) url;
-(NSArray *) parameters;
-(NSString *) method;
-(void) makeRequest;
-(void)request: (XMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response;
@end
