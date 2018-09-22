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
    
    self.songTitle = dictionary[@"name"];
    self.songUri = dictionary[@"uri"];
    NSString * artists = dictionary[@"artists"][0][@"name"];
    for (int i = 1; i< [dictionary[@"artists"] count]; i++){
        artists = [artists stringByAppendingString:@" and "];
        artists = [artists stringByAppendingString:dictionary[@"artists"][i][@"name"]];
    }
    self.songArtist = artists;
    self.songAlbum = dictionary[@"album"][@"name"];
    self.songAlbumArt = dictionary[@"album"][@"images"][0][@"url"];
    
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
