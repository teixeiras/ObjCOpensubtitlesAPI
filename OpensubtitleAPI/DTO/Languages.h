//
//  Languages.h
//  OpensubtitleAPI
//
//  Created by Filipe Teixeira on 05/07/14.
//  Copyright (c) 2014 Filipe Teixeira. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Languages : NSObject
@property (nonatomic, strong) NSString *ISO639;
@property (nonatomic, strong) NSString *LanguageName;
@property (nonatomic, strong) NSString *SubLanguageID;
@end
