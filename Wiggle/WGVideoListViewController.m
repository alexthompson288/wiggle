//
//  WGMasterViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGVideoListViewController.h"
#import "WGVideoViewController.h"
#import "WGVideo.h"

@interface WGVideoListViewController () {
}

@end

@implementation WGVideoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self.tableView selector:@selector(reloadData) name:WGVideosLoadedNotification object:nil];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [WGVideo allVideos].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGVideoCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    WGVideo *video      = [WGVideo allVideos][indexPath.row];
    
    cell.video = video;
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath                = [self.tableView indexPathForSelectedRow];
        WGVideoViewController *detailVC = (WGVideoViewController *)[segue destinationViewController];
        
        detailVC.video = [WGVideo allVideos][indexPath.row];
    }
}

@end

@implementation WGVideoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.thumbnailImageView makeInsetShadowWithRadius:1 Alpha:0.1];
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	_video = nil;
    self.thumbnailImageView.image = nil;
}

- (void)setVideo:(WGVideo *)video
{
    if (_video != video) {
        _video = video;
        self.titleLabel.text    = self.video.title;
        self.overviewLabel.text = self.video.overview;
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:self.video.thumbnailURL]];
    }
}

@end