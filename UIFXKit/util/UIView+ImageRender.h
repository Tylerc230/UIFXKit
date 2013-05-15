//
//  UIView+ImageRender.h
//  bestbuy_catalog_v4
//
//  Created by Tyler Casselman on 7/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 * Supports rendering all view contents to a UIImage
 *
 */
@interface UIView (ImageRender)
//Power of 2 image with the extra buffer space filled with black pixels
- (UIImage*)POTSnapshot;
//Image which is the size of the view.
- (UIImage *)snapshot;
@end
