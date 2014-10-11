//
//  WGSpashViewController.m
//  Wiggle
//
//  Created by Barnaby Malet on 06/10/2014.
//
//

#import "WGSpashViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface WGSpashViewController ()
@property (weak, nonatomic) IBOutlet UIButton *watchButton;
- (IBAction)watchButtonPressed:(id)sender;

@end

@implementation WGSpashViewController {
    MPMoviePlayerController *player;
}
- (BOOL) shouldAutorotate {
    return NO;
}

- (NSUInteger) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"homepage_park" ofType:@"mp4"]];//[[NSBundle mainBundle] URLForResource:@"splash" withExtension:@"mp4"];
    
    
    player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    player.shouldAutoplay = YES;
    
    [player setControlStyle:MPMovieControlStyleNone];
    [player setScalingMode:MPMovieScalingModeAspectFill];
    [player setFullscreen:FALSE];
    player.repeatMode = MPMovieRepeatModeOne;
    player.view.frame = self.view.frame;
    [self.view addSubview:player.view];
    [self.view sendSubviewToBack:player.view];
    
    
    [[self.watchButton layer] setBorderWidth:2.0f];
    [[self.watchButton layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.watchButton layer] setCornerRadius:3.0f];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [player play];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [player stop];
}

- (void)movieFinishedCallback {
}

- (IBAction)watchButtonPressed:(id)sender {
    [self presentViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"WGHomeNavigationController"] animated:NO completion:nil];
}
@end
