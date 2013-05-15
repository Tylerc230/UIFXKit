//
//  UIGLView.m
//  UIGLKit
//
//  Created by Tyler Casselman on 10/30/12.
//
//

#import "UIFXView.h"
@interface UIFXView ()

@end

@implementation UIFXView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
    }
    return self;
}


- (void)setSnapshot:(UIImage *)snapshot
{
    _snapshot = snapshot;
    [self.effect setSnapshot:snapshot];
}

- (void)setEffect:(UIFXBaseEffect *)effect
{
    _effect = effect;
}

- (void)showEffect:(BOOL)show
{
    if (show) {
    } else {
    }
    self.hidden = !show;

}

@end
