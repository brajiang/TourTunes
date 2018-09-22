//
//  SpotifySingleton.m
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import "SpotifySingleton.h"


@implementation SpotifySingleton

static SpotifySingleton *spotifySingletonInstance;

+(SpotifySingleton*)getInstance{
    if(spotifySingletonInstance == nil){
        spotifySingletonInstance = [[super alloc] init];
    }
    return spotifySingletonInstance;
}

-(void)setPlayer: (SPTAudioStreamingController*)audioPlayer{
    _player = audioPlayer;
}
-(SPTAudioStreamingController*)getPlayer{
    return _player;
}


@end
