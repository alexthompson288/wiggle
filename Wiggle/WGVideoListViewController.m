//
//  WGMasterViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGVideoListViewController.h"
#import "WGVideoDetailViewController.h"
#import "WGVideo.h"

@interface WGVideoListViewController () {
}

@end

@implementation WGVideoListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [WGVideo loadAll:^(BOOL succeeded, NSError *error) {
        [self.tableView reloadData];
    }];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
        WGVideoDetailViewController *detailVC = (WGVideoDetailViewController *)[segue destinationViewController];
        
        detailVC.video = [WGVideo allVideos][indexPath.row];
    }
}

@end

@implementation WGVideoCell

- (void)prepareForReuse
{
	[super prepareForReuse];
	self.video = nil;
}

- (void)setVideo:(WGVideo *)video
{
    if (_video != video) {
        _video = video;
        self.titleLabel.text = self.video.title;

    }
}

@end