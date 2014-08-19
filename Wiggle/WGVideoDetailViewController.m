//
//  WGDetailViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGVideoDetailViewController.h"
#import <MediaPlayer/MediaPlayer.h>

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
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:self.video.thumbnailURL]];

//        [self.thumbnailImageView setImage:[NSURL URLWithString:self.video.thumbnailURL]];
        self.navigationItem.title    = self.video.title;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self configureView];
}

- (IBAction)playVideo:(id)sender {
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]  initWithContentURL:[NSURL URLWithString:self.video.videoURL]];
    
    NSLog(@"--- %@", self.video.videoURL);
//    vc.controlStyle = MPMovieControlStyleFullscreen;
    
    [self presentMoviePlayerViewControllerAnimated:vc];
    
//    [theMoviPlayer play];

}

@end
