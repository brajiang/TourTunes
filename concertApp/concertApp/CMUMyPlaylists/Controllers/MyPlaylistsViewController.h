//
//  MyPlaylistsViewController.h
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifySong.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyPlaylistsViewController : UIViewController
@property NSMutableArray<SpotifySong *> *songs;
@end

NS_ASSUME_NONNULL_END
