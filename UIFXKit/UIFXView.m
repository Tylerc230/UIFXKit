//
//  UIGLView.m
//  UIGLKit
//
//  Created by Tyler Casselman on 10/30/12.
//
//

#import "UIFXView.h"
#import "QuartzCore/QuartzCore.h"

@interface UIFXView ()
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CFTimeInterval lastTimestamp;
@property (nonatomic, assign) BOOL animate;
@end

@implementation UIFXView
+ (void)initialize
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame context:[EAGLContext currentContext]];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.context = [EAGLContext currentContext];
        [self setup];
    }
    return self;
}

#pragma mark - GLKViewDelegate methods
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    if (!self.animate) {
        return;
    }
    glClearColor(0.f, 0.f, 0.f, .0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    CFTimeInterval duration = self.displayLink.timestamp - self.lastTimestamp;
    if (self.lastTimestamp == 0.f) {
        duration = 0.f;
    }
    [self.effect render:duration];
    self.lastTimestamp = self.displayLink.timestamp;
}

- (void)setSnapshot:(UIImage *)snapshot
{
    _snapshot = snapshot;
    [self.effect setSourceSnapshot:snapshot];
}

- (void)showEffect:(BOOL)show
{
    if (show) {
        [self display];
        self.animate = YES;
    } else {
        self.animate = NO;
    }
    if (show) {
        self.hidden = NO;
    } else {
        [UIView animateWithDuration:.75f animations:^{
            self.alpha = 0.f;
        } completion:^(BOOL finished) {
            self.hidden = YES;
            self.alpha = 1.f;
        }];
    }
}

- (void)setEffect:(UIFXBaseEffect *)effect
{
    _effect = effect;
    effect.viewSize = GLKVector2Make(self.frame.size.width, self.frame.size.height);
}

#pragma mark - Private
- (void)setup
{
    self.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    self.drawableMultisample = GLKViewDrawableMultisample4X;
    self.contentScaleFactor = [UIScreen mainScreen].scale;
    
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.delegate = self;
    self.userInteractionEnabled = NO;
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(display)];
    self.animate = NO;
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)setAnimate:(BOOL)animate
{
    _animate = animate;
    self.lastTimestamp = 0.f;
    self.displayLink.paused = !animate;
}

@end
