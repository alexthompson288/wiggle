//
//  WGVideoViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 01/09/2014.
//
//

#import "WGVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "WGTranscriptViewController.h"

const NSInteger kWGVideoInfoRow = 0;

@interface WGVideoViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *availableOfflineSwitch;
@property (weak, nonatomic) IBOutlet UILabel *downloadStatusLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *downloadProgressView;

- (void)configureView;

@end

@implementation WGVideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.thumbnailImageView makeInsetShadowWithRadius:1 Alpha:0.1];
    [self configureView];
}

-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*) indexPath
{
    if (indexPath.row == kWGVideoInfoRow){
        return self.videoOverviewLabel.frame.origin.y + self.videoOverviewLabel.frame.size.height + 15;
    }
    else {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadDidProgress:) name:WGVideoDownloadDidProgressNotification object:self.video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureView) name:WGVideoDownloadDidFinishNotification object:self.video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureView) name:WGVideoDownloadDidFailNotification object:self.video];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(configureView) name:WGVideoDownloadDidCancelNotification object:self.video];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WGVideoDownloadDidProgressNotification object:self.video];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WGVideoDownloadDidFinishNotification object:self.video];
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
        [self.videoOverviewLabel sizeToFit];
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

- (IBAction)toggleAvailableOffline:(id)sender {
    if (self.video.offlineURL || self.video.isDownloading){
        [self.video deleteDownload];
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
    [self.video videoWasWatched];
    [self presentMoviePlayerViewControllerAnimated:vc];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTranscript"]) {
        WGTranscriptViewController *detailVC = (WGTranscriptViewController *)[segue destinationViewController];
        
        detailVC.video = self.video;
    }
}


@end
