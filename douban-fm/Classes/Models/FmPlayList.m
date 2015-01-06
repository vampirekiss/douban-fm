//
//  FmPlayList.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "FmPlayList.h"


@implementation FmPlayList {
    
@private
    NSURL *_url;
    NSMutableArray *_array;
    NSUInteger _index;
}

- (id)initWithUrl:(NSURL *)url {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _url = url;
    
    _index = -1;
    
    return self;
}

- (id)initWithUrlString:(NSString *)urlString {
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [self initWithUrl:url];
    
}

- (NSUInteger)length {
    
    return [_array count];
    
}


- (void)loadNextSong:(void (^)(FmSong *))completion {
    
    if (_index < self.length - 1) {
        
        _index++;
        
        if (completion) {
            completion([_array objectAtIndex:_index]);
        }
        
        return;
    }
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        
        id songs = [JSON valueForKeyPath:@"song"];
        
        NSMutableArray *playList = [NSMutableArray arrayWithCapacity:[songs count]];
        
        for (NSDictionary *attributes in songs) {
        
            FmSong *song = [[FmSong alloc] initWithAttributes:attributes];
            
            [playList addObject:song];
        
        }
        
        _array = playList;
        
        _index = 0;
        
        if (completion) {
            completion([_array objectAtIndex:_index]);
        }
        
    } failure:nil];
    
    [operation start];
    
}

@end
