//
//  WGDetailViewController.h
//  Wiggle
//
//  Created by Barnaby Malet on 19/08/2014.
//
//

#import <UIKit/UIKit.h>

@interface WGDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
