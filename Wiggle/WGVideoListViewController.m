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
    
    return [[WGVideo allCategories] count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 32)];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"section-background"]];
    
    [headerView addSubview:backgroundImage];
    backgroundImage.top = 8;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:headerView.frame];
    titleLabel.text     = ((WGCategory *)[WGVideo allCategories][section]).title;
    titleLabel.font     = [UIFont fontWithName:@"HelveticaNeue" size:12];
    titleLabel.left     = 12;
    titleLabel.top      = 4;
    [headerView addSubview:titleLabel];
    return headerView;
}

- (WGVideo *)videoForIndexPath:(NSIndexPath *)indexPath
{
    return [(WGCategory *)[WGVideo allCategories][indexPath.section] objects][indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((WGCategory *)[WGVideo allCategories][section]).objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGVideoCell *cell   = [tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
    WGVideo *video      = [self videoForIndexPath:indexPath];
    
    cell.video = video;
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath                = [self.tableView indexPathForSelectedRow];
        WGVideoViewController *detailVC = (WGVideoViewController *)[segue destinationViewController];
        
        detailVC.video = [self videoForIndexPath:indexPath];
    }
}

@end

@implementation WGVideoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.thumbnailImageView makeInsetShadowWithRadius:1 Alpha:0.1];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

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
        self.titleLabel.text             = self.video.title;
        self.overviewLabel.text          = self.video.overview;
//        self.watchedIndicatorView.hidden = !self.video.watched;
        [self.thumbnailImageView setImageWithURL:[NSURL URLWithString:self.video.thumbnailURL]];
    }
}

- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

@end