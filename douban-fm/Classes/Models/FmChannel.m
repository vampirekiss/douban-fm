//
//  FmChannel.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "FmChannel.h"

static NSString * const channelUrlFormat = @"http://douban.fm/j/mine/playlist?&type=n&channel=%d&from=mainsite";


@implementation FmChannel {

@private
    FmPlayList *_playList;
    NSURL *_url;
}

@synthesize cid = _cid;
@synthesize name = _name;

+ (NSMutableArray *)defaultChannels {
    
    static NSMutableArray *_defaultChannels = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{

        NSString *jsonFile = [[NSBundle mainBundle] pathForResource:@"channelslist" ofType:@"json"];
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfFile:jsonFile];
        
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        id channels = [json valueForKey:@"channels"];
        
        _defaultChannels = [NSMutableArray arrayWithCapacity:[channels count]];
        
        for (NSDictionary *attributes in channels) {
            
            FmChannel *channel = [[FmChannel alloc] initWithAttributes:attributes];
            [_defaultChannels addObject:channel];
            
        }
        
    });
    
    return _defaultChannels;
}

- (id)initWithAttributes:(NSDictionary *)attributes {

    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _cid = [[attributes valueForKey:@"channel_id"] integerValue];
    _name = [attributes valueForKey:@"name"];
    
    return self;
}

- (NSURL *)url {
    
    if (!_url) {
        NSString *stringUrl = [[NSString alloc] initWithFormat:channelUrlFormat, _cid];
        _url = [NSURL URLWithString:stringUrl];
    }
    
    return _url;

}

- (FmPlayList *)playList {
    
    if (!_playList) {
        _playList = [[FmPlayList alloc] initWithUrl:self.url];
    }
    
    return _playList;
}

- (void)loadNextSong:(void (^)(FmSong *))completion {
    
    [[self playList] loadNextSong:completion];
    
}

@end
