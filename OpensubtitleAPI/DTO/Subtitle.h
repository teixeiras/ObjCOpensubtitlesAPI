//
//  Subtitle.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 16/06/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Subtitle : NSObject
@property NSString * NSIDMovie;
@property NSString * IDMovieImdb;
@property NSString * IDSubMovieFile;
@property NSString * IDSubtitle;
@property NSString * IDSubtitleFile;
@property NSString * ISO639;
@property NSString * LanguageName;
@property NSString * MatchedBy;
@property NSString * MovieByteSize;
@property NSString * MovieFPS;
@property NSString * MovieHash;
@property NSString * MovieImdbRating;
@property NSString * MovieKind;
@property NSString * MovieName;
@property NSString * MovieNameEng;
@property NSString * MovieReleaseName;
@property NSString * MovieTimeMS;
@property NSString * MovieYear;
@property NSString * SeriesEpisode;
@property NSString * SeriesIMDBParent;
@property NSString * SeriesSeason;
@property NSString * SubActualCD;
@property NSString * SubAddDate;
@property NSString * SubAuthorComment;
@property NSString * SubBad;
@property NSString * SubComments;
@property NSString * SubDownloadLink;
@property NSString * SubDownloadsCnt;
@property NSString * SubFeatured;
@property NSString * SubFileName;
@property NSString * SubFormat;
@property NSString * SubHD;
@property NSString * SubHash;
@property NSString * SubHearingImpaired;
@property NSString * SubLanguageID;
@property NSString * SubRating;
@property NSString * SubSize;
@property NSString * SubSumCD;
@property NSString * SubtitlesLink;
@property NSString * UserID;
@property NSString * UserNickName;
@property NSString * UserRank;
@property NSString * ZipDownloadLink;

-(void) populateWithNSDictionary:(NSDictionary *) dic;
@end
