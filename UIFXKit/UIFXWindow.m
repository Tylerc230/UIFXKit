//
//  UIGLWindow.m
//  UIGLKit
//
//  Created by Tyler Casselman on 10/30/12.
//
//

#import "UIFXWindow.h"
#import "UIFXView.h"
#import "UIView+ImageRender.h"
@interface UIFXWindow ()
@property (nonatomic, strong) UIFXView *fxView;
@property (nonatomic, strong) TransitionStartCallback transitionStarted;
@end

@implementation UIFXWindow
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.fxView = [[UIFXView alloc] initWithFrame:frame];
        self.fxView.hidden = YES;
        [self addSubview:self.fxView];

    }
    return self;
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    [self bringSubviewToFront:self.fxView];
}

#pragma mark - Public methods
+ (UIFXWindow *)keyWindow
{
    return (UIFXWindow *)[[UIApplication sharedApplication] keyWindow];
}

- (void)startTransition:(TransitionStartCallback)transitionStarted
{
    self.transitionStarted = transitionStarted;
    [self takeSnapshot];
    [self.fxView showEffect:YES];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(finishSnapshot) userInfo:nil repeats:NO];
}

- (void)endTransition
{
    [self.fxView showEffect:NO];
}

- (BOOL)showingTransition
{
    return !self.fxView.hidden;
}

- (void)setEffect:(UIFXBaseEffect *)effect
{
    _effect = effect;
    self.fxView.effect = effect;
}

#pragma mark - Private methods

- (void)takeSnapshot
{
    UIImage * snapshot = [self snapshot];
    [self.fxView setSnapshot:snapshot];
}

- (void)finishSnapshot
{
    [self takeSnapshot];
    self.transitionStarted();
}

@end
