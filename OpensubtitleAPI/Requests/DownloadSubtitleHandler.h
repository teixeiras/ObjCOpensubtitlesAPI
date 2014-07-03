//
//  DownloadSubtitleHandler.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 03/07/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "RequestHandler.h"

@interface DownloadSubtitleHandler : RequestHandler

@property (copy) void(^onDownloadSubtitlesSuccessed)(NSData *);
@property (copy) void(^onDownloadSubtitlesFailed)(int);

@property NSString * subtitleId;
@property NSString * token;
@end
