//
//  FmPlayList.h
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FmSong.h"
#import "AFJSONRequestOperation.h"


@interface FmPlayList : NSObject

- (id)initWithUrl:(NSURL *)url;
- (id)initWithUrlString:(NSString *)urlString;

- (void)loadNextSong:(void (^)(FmSong *))completion;


@property(nonatomic, readonly) NSUInteger length;

@end
