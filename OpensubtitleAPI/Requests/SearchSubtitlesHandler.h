//
//  SearchSubtitlesHandler.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "RequestHandler.h"

@interface SearchSubtitlesHandler : RequestHandler

@property (copy) void(^onSubtitlesFound)(BOOL,NSArray *);

@property NSString * sublanguageid;

@property NSArray * hashList;
@property NSArray * imdbid;

@end
