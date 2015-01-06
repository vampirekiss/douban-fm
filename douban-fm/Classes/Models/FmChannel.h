//
//  FmChannel.h
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FmPlayList.h"

@interface FmChannel : NSObject

@property(readonly) NSUInteger cid;
@property(readonly) NSString *name;

@property(weak, nonatomic, readonly) NSURL *url;

@property(weak, nonatomic, readonly) FmPlayList *playList;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (NSMutableArray *)defaultChannels;

- (void)loadNextSong:(void (^)(FmSong *))completion;


@end
