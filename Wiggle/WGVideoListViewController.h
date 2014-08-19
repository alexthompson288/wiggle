//
//  WGMasterViewController.h
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import <UIKit/UIKit.h>
#import "WGVideo.h"

@interface WGVideoListViewController : UITableViewController

@end

@interface WGVideoCell : UITableViewCell

@property (nonatomic, strong) WGVideo *video;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;


@end