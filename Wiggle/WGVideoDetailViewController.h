//
//  WGDetailViewController.h
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import <UIKit/UIKit.h>
#import "WGVideo.h"

@interface WGVideoDetailViewController : UIViewController

@property (strong, nonatomic) WGVideo *video;
@property (weak, nonatomic) IBOutlet UILabel *videoOverviewLabel;

@end

