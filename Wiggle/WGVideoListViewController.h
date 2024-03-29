//
//  WGMasterViewController.h
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import <UIKit/UIKit.h>
#import "WGVideo.h"

@interface WGVideoListViewController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@interface WGVideoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *watchedIndicatorView;
@property (weak, nonatomic) IBOutlet UIView *availableOfflineIndicatorView;

@property (nonatomic, strong) WGVideo *video;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *overviewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;


@end