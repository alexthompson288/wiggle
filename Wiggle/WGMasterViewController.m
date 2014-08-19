//
//  WGMasterViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import "WGMasterViewController.h"
#import "WGDetailViewController.h"
#import "WGVideo.h"

@interface WGMasterViewController () {
}

@end

@implementation WGMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [WGVideo loadAll:^(BOOL succeeded, NSError *error) {
        NSLog(@"All loaded %i %@ %i", succeeded, error, [WGVideo allVideos].count);
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    WGVideo *video = [WGVideo allVideos][indexPath.row];
    
    
    NSLog(@"XX %@", video.title);
    cell.textLabel.text = @"---";
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = nil;
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
