//
//  FmSong.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "FmSong.h"

@implementation FmSong {
    
@private
    NSString *_urlString;
    NSString *_imageUrlString;
}

@synthesize name = _name;

@synthesize album = _album;

@synthesize author = _author;

@synthesize company = _company;

@synthesize url = _url;

@synthesize imageUrl = _imageUrl;



- (id)initWithAttributes:(NSDictionary *)attributes {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _name = [attributes valueForKey:@"title"];
    _album = [attributes valueForKey:@"albumtitle"];
    _author = [attributes valueForKey:@"artist"];
    _company = [attributes valueForKey:@"company"];
    _urlString = [attributes valueForKey:@"url"];
    _imageUrlString = [[attributes valueForKey:@"picture"]
                       stringByReplacingOccurrencesOfString:@"mpic" withString:@"lpic"];
    
    
    _url = [NSURL URLWithString:_urlString];
    _imageUrl = [NSURL URLWithString:_imageUrlString];
    
    return self;
}


@end
