//
//  SearchMoviesOnIMDBHandler.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "RequestHandler.h"

@interface SearchMoviesOnIMDBHandler : RequestHandler

@property (copy) void(^onMoviesFound)(BOOL,NSArray *);

@property NSString * token;
@property NSString * query;
@end
