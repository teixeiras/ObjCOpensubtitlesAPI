//
//  OSubManager.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OSubManager;

@protocol OSubManagerDelegate

@optional
-(void) opensubitleAPI:(OSubManager *) sessionManager sessionStartSuccessWithResult:(BOOL) result;
-(void) opensubitleAPI:(OSubManager *) sessionManager sessionRestartSuccessWithResult:(BOOL) result;
-(void) opensubitleAPI:(OSubManager *) sessionManager subtitleSearchResponseSuccess:(BOOL) hasResults withResults:(NSArray *) result;
-(void) opensubitleAPI:(OSubManager *) sessionManager countryLanguagesResponseSuccess:(BOOL) hasResults withResults:(NSArray *) result;

-(void) opensubitleAPI:(OSubManager *) sessionManager subtitleDownloadWithData:(NSData *) results;
-(void) opensubitleAPI:(OSubManager *) sessionManager subtitleDownloadFailed:(int) error;

@end

@interface OSubManager : NSObject

@property BOOL useHash;

@property id<OSubManagerDelegate> delegate;

+(instancetype) sharedObject;

-(void) sessionStartOnResponse:(void(^)(BOOL)) onSuccess;
-(void) reloadSessionOnResponse:(void(^)(BOOL)) onSuccess;

-(void) retrieveCountryLanguagesLocalizedTo:(NSString *) language;
-(void) retrieveCountryLanguagesLocalizedTo:(NSString *) language onResult:(void(^)(BOOL,NSArray *)) onLanguageRetrieve;

-(void) addSearchLanguage:(NSString *) language;
-(void) removeLanguange:(NSString *) language;
-(void) cleanLanguage;

-(void) searchSubtitlesForPathName:(NSString *) pathName;
-(void) searchSubtitlesForPathName:(NSString *) pathName forLanguage:(NSDictionary *) language;


-(void) searchSubtitlesForString:(NSString *)string forLanguages:(NSArray *) languages;
-(void) searchSubtitlesForString:(NSString *)string;
-(void) searchSubtitlesForString:(NSString *) string onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;
-(void) searchSubtitlesForString:(NSString *) string forLanguages:(NSArray *) languages onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;

-(void) downloadSubtitleWithId:(NSString *) identifier;
-(void) downloadSubtitleWithId:(NSString *) identifier onDownloadFinish:(void(^)(NSData *)) onFinish onFail:(void(^)(int)) onFail;

@end
