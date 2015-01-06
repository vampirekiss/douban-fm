//
//  FmSong.h
//  douban-fm
//
//  Created by vampirekiss on 12-10-21.
//  Copyright (c) 2012年 vampirekiss. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFImageRequestOperation.h"

@interface FmSong : NSObject

- (id)initWithAttributes:(NSDictionary *)attributes;

@property(nonatomic, readonly) NSString *name;

@property(nonatomic, readonly) NSString *album;

@property(nonatomic, readonly) NSString *author;

@property(nonatomic, readonly) NSString *company;

@property(nonatomic, readonly) NSURL *url;

@property(nonatomic, readonly) NSURL *imageUrl;


@end
