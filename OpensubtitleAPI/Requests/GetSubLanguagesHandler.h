//
//  GetSubLanguagesHandler.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "RequestHandler.h"

@interface GetSubLanguagesHandler : RequestHandler

@property (copy) void(^onLanguageRetrieve)(BOOL,NSArray *);


@property NSString * language;
@end
