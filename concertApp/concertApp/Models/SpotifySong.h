//
//  SpotifySong.h
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpotifySong : NSObject
@property (nonatomic, strong) NSString *songUri;
@property (nonatomic, strong) NSString *songTitle;
@property (nonatomic, strong) NSString *songArtist;
@property (nonatomic, strong) NSString *songAlbum;
@property (nonatomic, strong) NSString *songAlbumArt;

+ (NSArray<SpotifySong *> *)songsWithArray:(NSArray *)dicts;
@end

NS_ASSUME_NONNULL_END
