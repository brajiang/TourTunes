//
//  BackendAPIManager.h
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpotifySingleton.h"
#import <SpotifyAudioPlayback/SpotifyAudioPlayback.h>
#import <SpotifyAuthentication/SpotifyAuthentication.h>
#import <SpotifyMetadata/SpotifyMetadata.h>
#import <UNIRest.h>

NS_ASSUME_NONNULL_BEGIN

@interface BackendAPIManager : NSObject
+ (void)getPlaylistWithId:(NSString *)playlistId Completion:(void(^)(NSDictionary *response))completion;

@end

NS_ASSUME_NONNULL_END
