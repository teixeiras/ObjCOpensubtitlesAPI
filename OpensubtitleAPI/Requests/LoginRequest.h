//
//  LoginRequest.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "RequestHandler.h"

@interface LoginRequest : RequestHandler

@property (copy) void(^onLogin)(BOOL);

@end
