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

@property (weak, nonatomic) IBOutlet UISwitch *availableOfflineSwitch;
@property (weak, nonatomic) IBOutlet UILabel *downloadStatusLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressView;

- (void)configureView;
@end

@implementation WGVideoDetailViewController

#pragma mark - Managing the detail item

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadDidProgress:) name:WGVideoDownloadDidProgressNotification object:self.video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadDidFinish:) name:WGVideoDownloadDidFinishNotification object:self.video];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WGVideoDownloadDidProgressNotification object:self.video];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WGVideoDownloadDidFinishNotification object:self.video];
}

- (void)downloadDidFinish:(NSNotification *)notification
{
    [self configureView];
}

- (void)downloadDidProgress:(NSNotification *)notification
{
    NSNumber *bytesDone     = [notification.userInfo objectForKey:@"totalBytesRead"];
    NSNumber *bytesTotal    = [notification.userInfo objectForKey:@"totalBytesExpectedToRead"];
    
    float percDone = [bytesDone floatValue] / [bytesTotal floatValue];
    self.downloadProgressView.progress = percDone;

    self.downloadStatusLabel.text = [NSString stringWithFormat:@"%.0f%% of %@", percDone * 100, [NSString stringWithFileSize:bytesTotal]];
}

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
        self.navigationItem.title    = self.video.title;
        self.downloadProgressView.progress = 0.0f;
        if (self.video.isDownloading){
            self.downloadStatusLabel.text = @"Calculating progress...";
            self.availableOfflineSwitch.on = YES;
            self.downloadProgressView.hidden = NO;
        }
        else if (self.video.offlineURL){
            self.downloadStatusLabel.text = @"Available offline";
            self.availableOfflineSwitch.on = YES;
            self.downloadProgressView.hidden = YES;
        }
        else {
            self.downloadStatusLabel.text = @"Not available offline";
            self.availableOfflineSwitch.on = NO;
            self.downloadProgressView.hidden = YES;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self configureView];
}

- (IBAction)toggleAvailableOffline:(id)sender {
    if (self.video.offlineURL){
//        [self.video deleteDownload];
    }
    else {
        [self.video download];
    }
    [self configureView];
}

- (IBAction)playVideo:(id)sender {
    NSURL *contentURL =  [NSURL URLWithString:self.video.offlineURL ? self.video.offlineURL : self.video.videoURL];
    
    
    
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]  initWithContentURL:contentURL];
    


    
    NSLog(@"playing %@", contentURL);
    [self presentMoviePlayerViewControllerAnimated:vc];
}

@end
