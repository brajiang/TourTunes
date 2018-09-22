//
//  BackendAPIManager.m
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import "BackendAPIManager.h"

@implementation BackendAPIManager

+ (void)getPlaylistWithId:(NSString *)playlistId Completion:(void(^)(NSDictionary *response))completion {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *headers = @{@"Accept": @"application/json",@"Content-Type": @"application/json", @"Authorization":[NSString stringWithFormat:@"Bearer %@", [defaults objectForKey:@"accessToken"]]};
    NSDictionary *parameters = @{};
    NSString *baseURL = @"https://api.spotify.com/v1/playlists/";
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseURL, playlistId];
    UNIHTTPJsonResponse *response = [[UNIRest get:^(UNISimpleRequest *request) {
        [request setUrl:urlString];
        [request setParameters:parameters];
        [request setHeaders:headers];
    }] asJson];
    completion(response.body.object);
}


@end
