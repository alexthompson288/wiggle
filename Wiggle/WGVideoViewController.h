//
//  WGVideoViewController.h
//  Wiggle
//
//  Created by Barnaby Malet on 01/09/2014.
//
//

#import <UIKit/UIKit.h>
#import "WGVideo.h"

#import <UIKit/UIKit.h>

@interface RelatedVideoCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@end


@interface WGVideoViewController : UITableViewController

@property (strong, nonatomic) WGVideo *video;
@property (weak, nonatomic) IBOutlet UILabel *videoOverviewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end
