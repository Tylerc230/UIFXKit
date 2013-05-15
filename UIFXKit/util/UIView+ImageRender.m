//
//  UIView+ImageRender.m
//  bestbuy_catalog_v4
//
//  Created by Tyler Casselman on 7/5/12.
//  Copyright (c) 2012 Casselman Consulting. All rights reserved.
//

#import "UIView+ImageRender.h"
#import "QuartzCore/QuartzCore.h"
#import "glMath.h"
@implementation UIView (ImageRender)

- (UIImage*)POTSnapshot
{
    return [self snapShotWithSize:CGSizeMake(nextPowOf2(self.bounds.size.width), nextPowOf2(self.bounds.size.height))];
}

- (UIImage *)snapshot
{
    return [self snapShotWithSize:self.bounds.size];
}

- (UIImage *)snapShotWithSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [[self layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot;
}

@end

