//
//  WGDetailViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGVideoDetailViewController.h"

@interface WGVideoDetailViewController ()
- (void)configureView;
@end

@implementation WGVideoDetailViewController

#pragma mark - Managing the detail item

- (void)setVideo:(WGVideo *)video
{
    if (_video != video) {
        _video = video;
        [self configureView];
    }
}

- (void)configureView
{
    if (self.video) {
        self.videoOverviewLabel.text = self.video.overview;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

@end
