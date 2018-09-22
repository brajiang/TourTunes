//
//  SongCell.h
//  concertApp
//
//  Created by Connor Clancy on 9/22/18.
//  Copyright © 2018 Connor Clancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifySong.h"

NS_ASSUME_NONNULL_BEGIN

@interface SongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) SpotifySong *song;
@end

NS_ASSUME_NONNULL_END
