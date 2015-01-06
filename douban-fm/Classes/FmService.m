//
//  FmService.m
//  douban-fm
//
//  Created by lau string on 12-10-24.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "FmService.h"

@interface FmService ()

- (void)playSong:(FmSong *)song;

- (void)playerItemDidPlayToEnd:(id)notification;

- (void)playerDurationWatching:(NSTimer *)timer;

- (void)loadSongThumb:(FmSong *)song;

- (void)initWatchTimer;

- (AVPlayerItem *)createPlayerItem:(NSURL *)url;

- (void)beginBackgroundTask;

@end

@implementation FmService {

@private
    
    AVPlayer *_audioPlayer;
    
    NSTimer *_durationTimer;
    
    NSMutableSet *_observers;
    
    UIBackgroundTaskIdentifier _backgroundTaskId;
    
}


@synthesize channels = _channels;
@synthesize currentChannelIndex = _currentChannelIndex;


+ (FmService *)sharedInstance {
    
    static FmService *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[FmService alloc] init];
        
    });
    
    return instance;
}


- (id)init {
    
    if (self = [super init]) {
        
        _currentChannelIndex = 0;
        
        _audioPlayer = [[AVPlayer alloc] init];
                
        _channels = [FmChannel defaultChannels];
        
        _observers = [[NSMutableSet alloc] init];
        
        _backgroundTaskId = UIBackgroundTaskInvalid;
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [[AVAudioSession sharedInstance] setActive:YES error:nil];

    }
    
    return self;
}

- (void)dealloc {
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter removeObserver:self];
    
    for (id observer in _observers) {
        
        [notificationCenter removeObserver:observer];
        
    }
    
    if (_durationTimer) {
        
        [_durationTimer invalidate];
        
    }
    
}


- (void)addNotificationObserver:(NSString *)notification observer:(id)observer selector:(SEL)selector {
    
    [[NSNotificationCenter defaultCenter] addObserver:observer
                                             selector:selector name:notification object:nil];
    
    [_observers addObject:observer];
}

- (void)postNoification:(NSString *)notification withObject:(id)object {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:object];
    
}

- (NSInteger)channelIndexWithName:(NSString *)channelName {
    
    NSInteger index = -1;
    
    for (FmChannel *channel in _channels) {
        
        index++;
        
        if ([channel.name isEqual:channelName]) {
            
            break;
            
        }
    
    }

    return index;
}

- (FmChannel *)channelWithName:(NSString *)channelName {
    
    NSInteger index = [self channelIndexWithName:channelName];
    
    if (index != -1) {
        return [_channels objectAtIndex:index];
    }
    
    return nil;
}

- (FmChannel *)currentChannel {

    return [self.channels objectAtIndex:_currentChannelIndex];
    
}


- (void)pause {

    [_audioPlayer pause];
    
    self.isPlaying = NO;
    
}

- (void)play {
    
    [_audioPlayer play];
    
    self.isPlaying = YES;
}

- (void)loadSongThumb:(FmSong *)song {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:song.imageUrl];
    
    [request setHTTPShouldHandleCookies:NO];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    
    [[AFImageRequestOperation imageRequestOperationWithRequest:request
      
        imageProcessingBlock:nil

        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
           
           [self postNoification:kNotificationSongThumbloaded withObject:image];
           
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
           
           [self postNoification:kNotificationSongThumbloaded withObject:nil];
           
        }
      
    ] start];
    
}

- (void)playSong:(FmSong *)song {
    
    
    AVPlayerItem *playerItem = [self createPlayerItem:song.url];
    
    [_audioPlayer replaceCurrentItemWithPlayerItem:playerItem];
    [_audioPlayer play];
    
    self.isPlaying = YES;
    
    [self initWatchTimer];

    [self beginBackgroundTask];

}

- (void)playNextSong {
        
    [[self currentChannel] loadNextSong:^(FmSong *song) {
        
        [self loadSongThumb:song];
        [self postNoification:kNotificationSongloaded withObject:song];
        [self playSong:song];
        
    }];
    
}

- (void)playerItemDidPlayToEnd:(id)notification {
    
    [self postNoification:kNotificationSongPlayFinished withObject:self];
    
}

- (void)playerDurationWatching:(NSTimer *)timer {
    
    AVPlayerItem *playerItem = _audioPlayer.currentItem;
    
    if (playerItem) {
        
        CMTime currentTime = playerItem.currentTime;
        
        long seconds = currentTime.value / currentTime.timescale;
        
        [self postNoification:kNotificationSongDurationChanged withObject:[NSNumber numberWithLong:seconds]];
        
    }
    
}

- (void)initWatchTimer {
    
    if (!_durationTimer) {
        
        _durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.f
                                                        target:self selector:@selector(playerDurationWatching:)
                                                        userInfo:nil repeats:YES];
        
    }
    
}

- (AVPlayerItem *)createPlayerItem:(NSURL *)url {
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    
    return playerItem;
    
}

- (void)beginBackgroundTask {
    
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;
    
    newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:NULL];
    
    if (newTaskId != UIBackgroundTaskInvalid) {
        
        if (_backgroundTaskId != UIBackgroundTaskInvalid) {
        
            [[UIApplication sharedApplication] endBackgroundTask: _backgroundTaskId];
        
        }
    }
    
    _backgroundTaskId = newTaskId;
    
}

@end
