//
//  UIView+Shadow.h
//  Wiggle
//
//  Created by Barnaby Malet on 01/09/2014.
//
//

#import <UIKit/UIKit.h>

@interface UIView (Shadow)

- (void) makeInsetShadow;
- (void) makeInsetShadowWithRadius:(float)radius Alpha:(float)alpha;
- (void) makeInsetShadowWithRadius:(float)radius Color:(UIColor *)color Directions:(NSArray *)directions;

@end
