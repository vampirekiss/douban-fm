//
//  FmService.h
//  douban-fm
//
//  Created by lau string on 12-10-24.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "AFImageRequestOperation.h"
#import "FmChannel.h"
#import "FmSong.h"

static NSString * const kNotificationChannelDidSelected = @"douban.fm.app.channel.didSelected";

static NSString * const kNotificationSongThumbloaded = @"douban.fm.app.song.thumbLoaded";

static NSString * const kNotificationSongloaded = @"douban.fm.app.song.loaded";

static NSString * const kNotificationSongPlayFinished= @"douban.fm.app.song.playFinished";

static NSString * const kNotificationSongDurationChanged = @"doubam.fm.app.song.durationChanged";


@interface FmService : NSObject

+ (FmService *)sharedInstance;

- (void)playNextSong;

- (void)pause;

- (void)play;

- (void)addNotificationObserver:(NSString *) notification observer:(id)observer selector:(SEL)selector;

- (void)postNoification:(NSString *)notification withObject:(id)object;

- (NSInteger)channelIndexWithName:(NSString *)channelName;

- (FmChannel *)channelWithName:(NSString *)channelName;

- (FmChannel *)currentChannel;


@property (nonatomic, readonly) NSMutableArray *channels;

@property (nonatomic) NSUInteger currentChannelIndex;

@property (nonatomic) BOOL isPlaying;

@end