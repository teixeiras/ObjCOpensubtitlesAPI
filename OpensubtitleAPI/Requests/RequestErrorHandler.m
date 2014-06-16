//
//  RequestErrorHandler.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "RequestErrorHandler.h"

@implementation RequestErrorHandler
-(instancetype) sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [RequestErrorHandler new];
    });
    return instance;
}

-(NSDictionary *) errorMatrix {
    static NSMutableDictionary * errors;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        errors = [NSMutableDictionary new];
        errors[@200] = @"200 OK";
        errors[@206] = @"206 Partial content; message";
        
        errors[@401] = @"401 Unauthorized";
        errors[@402] = @"402 Subtitles has invalid format";
        errors[@403] = @"403 SubHashes (content and sent subhash) are not same!";
        errors[@404] = @"404 Subtitles has invalid language!";
        errors[@405] = @"405 Not all mandatory parameters was specified";
        errors[@406] = @"406 No session";
        errors[@407] = @"407 Download limit reached";
        errors[@408] = @"408 Invalid parameters";
        errors[@409] = @"409 Method not found";
        errors[@410] = @"410 Other or unknown error";
        errors[@411] = @"411 Empty or invalid useragent";
        errors[@412] = @"412 %s has invalid format (reason)";
        errors[@501] = @"501 Temporary down";
        errors[@503] = @"503 Service Unavailable";
        errors[@301] = @"301 Moved (to ​http://api.opensubtitles.org/xml-rpc)";
        
    });
    return errors;
}

-(BOOL) hasErrorOccurredWithMessage:(NSString *) message onMessageFind:(void(^)(BOOL, NSNumber *, NSString *)) event {
    
    __block BOOL error = NO;
    [[self errorMatrix] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([obj isEqualToString:message]) {
            
            if ([key isEqualToNumber:@200] || [key isEqualToNumber:@206]) {
                (event)(NO, key, obj);
                error = NO;
                
            } else {
                
                (event)(YES, key, obj);
                error = YES;
            }
        }
    }];
    
    return error;
}
@end
