//
//  Subtitle.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "Subtitle.h"

@implementation Subtitle
-(void) populateWithNSDictionary:(NSDictionary *) dic {
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [self setValue:obj forKeyPath:key];
        }
        
    }];
    
}
@end
