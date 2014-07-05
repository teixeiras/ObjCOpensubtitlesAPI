//
//  RequestErrorHandler.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestErrorHandler : NSObject
+(instancetype) sharedInstance;
-(BOOL) hasErrorOccurredWithMessage:(NSString *) message onMessageFind:(void(^)(BOOL, NSNumber *, NSString *)) event ;

@end
