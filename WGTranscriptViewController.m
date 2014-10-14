//
//  WGTranscriptViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 01/09/2014.
//
//

#import "WGTranscriptViewController.h"

@interface WGTranscriptViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *transcriptLabel;
@end

@implementation WGTranscriptViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
    [self configureView];
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)configureView
{
    self.transcriptLabel.text = self.video.transcript;
    [self.transcriptLabel sizeToFit];
    self.scrollView.contentSize = CGSizeMake(320, self.transcriptLabel.frame.size.height + 20);
}

@end
