ObjCOpensubtitlesAPI
====================
This static library was written to help any third party software using objective-c to implement opensubtitles in any application without almost any code.

###API
You can use the API using or delegate or blocks

OSubManagerDelegate

	-(void) opensubitleAPI:(OSubManager *) sessionManager sessionStartSuccessWithResult:(BOOL) result;  

	-(void) opensubitleAPI:(OSubManager *) sessionManager sessionRestartSuccessWithResult:(BOOL) result;

Usually you don't need to implement this method. This method gives you the opportunity to know if session requests results. 
The search and others queries will handle this requests for you.


	-(void) opensubitleAPI:(OSubManager *) sessionManager subtitleSearchResponseSuccess:(BOOL) hasResults withResults:(NSArray *) result;

Method called whenever there is a search result. 

	-(void) opensubitleAPI:(OSubManager *) sessionManager countryLanguagesResponseSuccess:(BOOL) hasResults withResults:(NSArray *) result;

Method called when there is a request for the existent country codes.

####Init the Manager
OSubManager It's manager. You can do all using this class. 

Example using blocks:

	#include "OpensubtitleAPI.h"
	// 3 letters country code (You can retrieve it from the API) with the subtitles language, you can add several.
	[[OSubManager sharedObject]	addSearchLanguage:@"por"];
	
	[[OSubManager sharedObject] searchSubtitlesForString:@"Orange Machine" onQuery:^(BOOL hasResults, NSArray * results) {
		if (hasResults) {
			foreach (Subtitle * subtitle in results) {
				//Do something with the subtitles
			}
		} else {
			//No subtitle found
		}
	}];

####Country Codes
You can request an NSArray with NSDictionary with country code (2 and 3 letters), localized country name.


#####Using delegates:
-(void) retrieveCountryLanguagesLocalizedTo:(NSString *) language;

#####Using blocks
-(void) retrieveCountryLanguagesLocalizedTo:(NSString *) language onResult:(void(^)(BOOL,NSArray *)) onLanguageRetrieve;

####Search for subtitle by name:
This search will use the imdb to search the id from the movie in imdb database and next it will search the subtitle at opensubtitle db returning an array of Subtitle objects (contains url to download, movie id, movie information, etc).

#####Using delegates:

-(void) searchSubtitlesForString:(NSString *)string forLanguages:(NSArray *) languages;
-(void) searchSubtitlesForString:(NSString *)string;

#####Using blocks
-(void) searchSubtitlesForString:(NSString *) string onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;
-(void) searchSubtitlesForString:(NSString *) string forLanguages:(NSArray *) languages onQuery:(void(^)(BOOL,NSArray *)) onSubtitlesFound;


###TODO:
1.Support to download directly from API - Almost there :P

