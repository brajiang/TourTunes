//
//  SpotifySingleton.h
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpotifySingleton : NSObject

@property (nonatomic) SPTAuth *auth;
@property (nonatomic) SPTAudioStreamingController *player;

+(SpotifySingleton*)getInstance;
-(void)setPlayer: (SPTAudioStreamingController*)player;
-(SPTAudioStreamingController*)getPlayer;

@end

NS_ASSUME_NONNULL_END
