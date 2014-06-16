//
//  OSubManager.m
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 15/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import "OSubManager.h"
#import "LoginRequest.h"
#import "MTKObserving.h"
#import "SearchMoviesOnIMDBHandler.h"
#import "SearchSubtitlesHandler.h"
#import "GetSubLanguagesHandler.h"
#import "Subtitle.h"

@interface OSubManager()
@property (nonatomic, strong) LoginRequest * loginRequest;

@property (nonatomic, strong) NSString * token;

@property (nonatomic, strong) NSMutableArray * languages;
@end

@implementation OSubManager


+(instancetype) sharedObject {
    static id osubManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        osubManager = [[self class] new];
    });
    return osubManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.languages = [NSMutableArray new];
        [self.languages addObject:@"por"];
    }
    return self;
}
-(void) sessionStartOnResponse:(void(^)(BOOL)) onSuccess {
    self.loginRequest = [LoginRequest new];
    
    //Will observe for changes on token
    [self observeProperty:@keypath(self.loginRequest.token) withBlock:
     ^(__weak typeof(self) self, NSString *oldToken, NSString *newToken) {
         self.token = newToken;
     }];
    
    self.loginRequest.onLogin = onSuccess;
    [self.loginRequest makeRequest];
    
}

-(void)reloadSessionOnResponse:(void(^)(BOOL)) onSuccess {
    if (!self.loginRequest) {
        [self sessionStartOnResponse:^(BOOL success) {
            onSuccess(success);
        }];
        return;
    }
    self.loginRequest.onLogin = onSuccess;
    [self.loginRequest makeRequest];
}



-(void) logout {
    // Not implemented
}

-(void) noOperation {
    // Not implemented
}

-(void) countryLanguagesOnRetrieve:(void(^)(BOOL,NSArray *)) onLanguageRetrieve {
    GetSubLanguagesHandler * handler = [GetSubLanguagesHandler new];
    handler.onLanguageRetrieve = onLanguageRetrieve;
    [handler makeRequest];
}

-(void) addSearchLanguage:(NSDictionary *) language {
    [self.languages addObject:language];
}

-(void) removeLanguange:(NSDictionary *) language {
    [self.languages removeObject:language];
}

-(void) cleanLanguage {
    [self.languages removeAllObjects];
}

-(void) searchSubtitlesForPathName:(NSString *) pathName onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound{
    [self searchSubtitlesForPathName:pathName forLanguage:self.languages onQuery:onSubtitlesFound];
}

-(void) searchSubtitlesForPathName:(NSString *) pathName forLanguage:(NSArray *) languages onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound{
    NSString* fileName = [[pathName lastPathComponent] stringByDeletingPathExtension];
    [self searchSubtitlesForString:fileName forLanguage:languages onQuery:onSubtitlesFound];
}

-(void) searchSubtitlesForString:(NSString *) string onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound {
    [self searchSubtitlesForString:string forLanguage:self.languages onQuery:onSubtitlesFound];

}

-(void) searchSubtitlesForString:(NSString *) string forLanguage:(NSArray *) languages onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound{
    
    SearchMoviesOnIMDBHandler * imdbSearch = [SearchMoviesOnIMDBHandler new];
    
    imdbSearch.query = string;
    imdbSearch.onMoviesFound=^(BOOL hasResults, NSArray * results) {
        if (hasResults) {
            
            NSMutableArray * imdbIDs = [NSMutableArray new];
            for (NSDictionary * imdbid in results) {
                [imdbIDs addObject:imdbid[@"id"]];
            }
            SearchSubtitlesHandler * subtitlesHandler = [SearchSubtitlesHandler new];
            subtitlesHandler.token = self.token;
            subtitlesHandler.sublanguageid = [languages componentsJoinedByString:@","];
            subtitlesHandler.imdbid = imdbIDs;//[imdbIDs componentsJoinedByString:@","];
            subtitlesHandler.onSubtitlesFound = onSubtitlesFound;
            [subtitlesHandler makeRequest];
            
        } else {
            (onSubtitlesFound)(NO, nil);
        }
    };
    
    
    if (!self.token) {
        [self reloadSessionOnResponse:^(BOOL success) {
            if (success) {
                imdbSearch.token = self.token;
                [imdbSearch makeRequest];
            } else {
                (onSubtitlesFound)(NO, nil);
            }
            
        }];
    } else {
        
        [imdbSearch makeRequest];
    }
}

@end
