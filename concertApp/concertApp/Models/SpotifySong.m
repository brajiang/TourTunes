//
//  SpotifySong.m
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import "SpotifySong.h"

@implementation SpotifySong
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    self.songTitle = dictionary[@"track"][@"name"];
    self.songUri = dictionary[@"track"][@"uri"];
    NSString * artists = dictionary[@"track"][@"artists"][0][@"name"];
    self.songArtist = artists;
    self.songAlbum = dictionary[@"track"][@"album"][@"name"];
    self.songAlbumArt = dictionary[@"track"][@"album"][@"images"][0][@"url"];
    
    return self;
}

+ (NSArray<SpotifySong *> *)songsWithArray:(NSArray *)dicts {
    NSMutableArray *output = [NSMutableArray new];
    for (NSDictionary *dict in dicts) {
        [output addObject:[[SpotifySong alloc] initWithDictionary:dict]];
    }
    return output;
}
@end
