//
//  OSubManager.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OSubManager : NSObject

@property BOOL useHash;

+(instancetype) sharedObject;

-(void) sessionStartOnResponse:(void(^)(BOOL)) onSuccess;

-(void) reloadSessionOnResponse:(void(^)(BOOL)) onSuccess;

-(void) countryLanguagesOnRetrieve:(void(^)(BOOL,NSArray *)) onLanguageRetrieve;
;

-(void) addSearchLanguage:(NSString *) language;
-(void) removeLanguange:(NSString *) language;
-(void) cleanLanguage;

-(void) searchSubtitlesForPathName:(NSString *) pathName onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;
-(void) searchSubtitlesForPathName:(NSString *) pathName forLanguage:(NSArray *) languages onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;
-(void) searchSubtitlesForString:(NSString *) string onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;
-(void) searchSubtitlesForString:(NSString *) string forLanguage:(NSArray *) languages onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;
@end
