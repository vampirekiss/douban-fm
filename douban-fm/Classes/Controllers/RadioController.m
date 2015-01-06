//
//  RadioController.m
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import "RadioController.h"

#define kSmallTextShadowColor [UIColor colorWithRed:93.f/255 green:88.f/255 blue:81.f/255 alpha:1.0f]
#define kSongSmallTextShadowColor [UIColor colorWithRed:59.f/255 green:56.f/255 blue:59.f/255 alpha:1.0f]
#define kSmallTextShadowOffset CGSizeMake(2.0f, 2.0f)


@interface RadioController ()

- (void)playNext;

- (void)setupFmService;

- (void)channelDidSelected:(id)notification;

- (void)songLoaded:(id)notification;

- (void)thumbImageLoaded:(id)notification;

- (void)songPlayFinished:(id)notification;

- (void)songDurationChanged:(id)notification;

- (void)likeButtonClicked:(UIButton *)sender;

- (void)hateButtonClicked:(UIButton *)sender;

- (void)skipButtonClicked:(UIButton *)sender;

@end


@implementation RadioController {
    
@private
    
    UILabel *_labelTitle;
    
    UIChannelPickerView *_pickerView;
    
    UIRadioThumbView *_thumbView;
    
    UILabel *_labelSongPlayingTime;
    UILabel *_labelSongTitle;
    
    UIRadioLikeButton *_likeButton;
    
    UIImageView *_shareCornerView;
    
    FmService *_fmService;

}

#pragma mark - Controller Methods

- (id)init
{
    self = [super init];
    
    if (self) {
    
        self.title = @"豆瓣FM";
        
        [self setupFmService];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    
    
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 10.f, 320.f, 20.f)];
    _labelTitle.textAlignment = UITextAlignmentCenter;
    _labelTitle.font = [UIFont systemFontOfSize:12.f];
    _labelTitle.text = @"公共兆赫";
    _labelTitle.textColor = [UIColor whiteColor];
    _labelTitle.backgroundColor = [UIColor clearColor];
    _labelTitle.shadowColor = kSmallTextShadowColor;
    _labelTitle.shadowOffset = kSmallTextShadowOffset;
    [self.view addSubview:_labelTitle];
    
    
    CGRect pickerFrame = CGRectMake(30.f, 40.f, 260.f, 40.f);
    _pickerView = [[UIChannelPickerView alloc] initWithFrame:pickerFrame];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.itemFont = [UIFont boldSystemFontOfSize:20.f];
    _pickerView.selectedItemFont = [UIFont boldSystemFontOfSize:30.f];
    _pickerView.selectedIndex = 0;
    _pickerView.insets = UIEdgeInsetsMake(0.f, 75.f, 0.f, 75.f);
    
    [self.view addSubview:_pickerView];
    
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line.png"]];
    CGRect lineFrame = line.frame;
    lineFrame.origin.y = 85.f;
    lineFrame.size.height=  2.f;
    line.frame = lineFrame;
    [self.view addSubview:line];
    
    
    _thumbView = [[UIRadioThumbView alloc] initWithFrame:CGRectMake(80.f, 110.f, 160.f, 160.f)];
    [_thumbView setImage:[UIImage imageNamed:@"cover.png"] reflected:NO];
    [self.view addSubview:_thumbView];
    
    _labelSongPlayingTime = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 285.f, 320.f, 20.f)];
    _labelSongPlayingTime.font = [UIFont systemFontOfSize:12.f];
    _labelSongPlayingTime.textAlignment = UITextAlignmentCenter;
    _labelSongPlayingTime.textColor = [UIColor whiteColor];
    _labelSongPlayingTime.backgroundColor = [UIColor clearColor];
    _labelSongPlayingTime.shadowColor = kSongSmallTextShadowColor;
    _labelSongPlayingTime.shadowOffset = kSmallTextShadowOffset;
    [self.view addSubview:_labelSongPlayingTime];
    
    _labelSongTitle = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 305.f, 320.f, 20.f)];
    _labelSongTitle.textAlignment = UITextAlignmentCenter;
    _labelSongTitle.textColor = [UIColor whiteColor];
    _labelSongTitle.backgroundColor = [UIColor clearColor];
    _labelSongTitle.font = [UIFont systemFontOfSize:15.f];
    _labelSongTitle.shadowColor = kSongSmallTextShadowColor;
    _labelSongTitle.shadowOffset = kSmallTextShadowOffset;
    [self.view addSubview:_labelSongTitle];
    
    _likeButton = [[UIRadioLikeButton alloc] initWithFrame:CGRectMake(48.f, 340.f, 58.f, 58.f)];
    [_likeButton setImage:[UIImage imageNamed:@"like_01.png"] forState:UIControlStateNormal];
    [_likeButton setLikedImage:[UIImage imageNamed:@"like_02.png"]];
    [_likeButton addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_likeButton];
    
    UIButton *hateButton = [[UIButton alloc] initWithFrame:CGRectMake(130.f, 340.f, 58.f, 58.f)];
    [hateButton setImage:[UIImage imageNamed:@"hate_01.png"] forState:UIControlStateNormal];
    [hateButton addTarget:self action:@selector(hateButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:hateButton];
    
    UIButton *skipButton = [[UIButton alloc] initWithFrame:CGRectMake(213.f, 340.f, 58.f, 58.f)];
    [skipButton setImage:[UIImage imageNamed:@"skip_01.png"] forState:UIControlStateNormal];
    [skipButton addTarget:self action:@selector(skipButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:skipButton];
    
    _shareCornerView = [[UIImageView alloc] initWithFrame:CGRectMake(280.f, 379.f, 40.f, 40.f)];
    _shareCornerView.image = [UIImage imageNamed:@"share_corner.png"];
    [self.view addSubview:_shareCornerView];
    
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)dealloc {
    
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    
    if (event.type == UIEventTypeRemoteControl) {
        
        switch (event.subtype) {
                
            case UIEventSubtypeRemoteControlTogglePlayPause:
                NSLog(@"paused");
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"prev");
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"next");
                break;
                
            default:
                break;  
        }  
    }
    
    NSLog(@"recv event %@", event);
    
}

- (void)setupFmService {
    
    _fmService = [FmService sharedInstance];
    
    
    [_fmService addNotificationObserver:kNotificationChannelDidSelected
                               observer:self
                               selector:@selector(channelDidSelected:)];
    
    [_fmService addNotificationObserver:kNotificationSongloaded
                               observer:self
                               selector:@selector(songLoaded:)];
    
    [_fmService addNotificationObserver:kNotificationSongThumbloaded
                               observer:self
                               selector:@selector(thumbImageLoaded:)];
    
    [_fmService addNotificationObserver:kNotificationSongPlayFinished
                               observer:self
                               selector:@selector(songPlayFinished:)];
    
    [_fmService addNotificationObserver:kNotificationSongDurationChanged
                               observer:self
                               selector:@selector(songDurationChanged:)];
    
}

- (void)playNext {
    
    [_fmService playNextSong];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    NSInteger index = [_fmService currentChannelIndex];
    
    if (_pickerView.selectedIndex != index) {
        
        [_pickerView setSelectedIndex:index animated:YES];
        
    }
    
}

#pragma mark - FmService Notifications

- (void)channelDidSelected:(id)notification {
    
    NSString *channelName = (NSString *)[notification object];
    
    NSInteger index = [_fmService channelIndexWithName:channelName];
    
    if (index != -1) {
        
        _fmService.currentChannelIndex = index;
        
        _pickerView.selectedIndex = index;
        
    }
    
}

- (void)songLoaded:(id)notification {

    FmSong *song = (FmSong *)[notification object];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        _labelSongPlayingTime.layer.opacity = 0.0f;
        _labelSongTitle.layer.opacity = 0.0f;
        
    } completion:^(BOOL finished) {
        
        if (!finished) {
            return;
        }
        
        _labelSongPlayingTime.text = @"00:00";
        _labelSongTitle.text = [NSString stringWithFormat:@"%@ - %@", song.author, song.name];
        
        [UIView animateWithDuration:0.5f animations:^{
            
            _labelSongPlayingTime.layer.opacity = 1.0f;
            _labelSongTitle.layer.opacity = 1.0f;
            
        }];
        
    }];
    
}

- (void)thumbImageLoaded:(id)notification {
    
    UIImage *image = (UIImage *)[notification object];
    
    if (image == nil) {
        
        [_thumbView setImage:[UIImage imageNamed:@"no_cover.png"] reflected:NO];
        
    } else {
        
        [_thumbView setImage:image reflected:YES];
        
    }
    
}

- (void)songPlayFinished:(id)Notification {
    
    [self playNext];
    
}

- (void)songDurationChanged:(id)notification {
    
    int playedTime = [[notification object] intValue];
    
    int minute = 60;
    
    NSString *timeText = nil;
    
    if (playedTime < minute) {
        
         timeText = [NSString stringWithFormat:@"00:%02d", playedTime];
        
    } else {
        
        int mod = playedTime % minute;
        int min = playedTime / minute;
        
        timeText = [NSString stringWithFormat:@"%02d:%02d", min, mod];
        
    }

    _labelSongPlayingTime.text = timeText;
    
}


#pragma mark - Event Handlers

- (void)likeButtonClicked:(UIButton *)sender {
    
    UIRadioLikeButton *likeButton = (UIRadioLikeButton *)sender;
    
    if (likeButton.isLiked) {
        
        likeButton.isLiked = NO;
        
    } else {
        
        likeButton.isLiked = YES;
        
    }
    
}

- (void)hateButtonClicked:(UIButton *)sender {
    
    
    
}

- (void)skipButtonClicked:(UIButton *)sender {
    
    [self playNext];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.view];
    
    if (point.x >= _shareCornerView.frame.origin.x) {
        
        if (point.y >= _shareCornerView.frame.origin.y) {
            
            // todo redirect to shardController
            
            return;
        }
        
    }
    
    CGRect frame = _thumbView.frame;
    
    if (point.x >= frame.origin.x && point.x <= frame.origin.x + frame.size.width) {
        
        if (point.y >= frame.origin.y && point.y <= frame.origin.x + frame.size.height) {
            
            if (_fmService.isPlaying) {
                
                [_fmService pause];
            
            } else {
                
                [_fmService play];
                
            }
            
            return;
        }
        
    }
    
}

#pragma mark - UIChannelPickerViewDataSource

- (NSUInteger)pickerViewNumberOfPickItems {
    
    return _fmService.channels.count;
    
}

- (NSString *)pickerViewTitleForPickItem:(NSUInteger)index {
    
    FmChannel *channel = [_fmService.channels objectAtIndex:index];
    
    return channel.name;

}

#pragma mark - UIChannelPickerViewDeleage

- (void)pickerViewDidSelectItem:(NSUInteger)index {
    
    _fmService.currentChannelIndex = index;
    
    [self playNext];
    
}


@end
