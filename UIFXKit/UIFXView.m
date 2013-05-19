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
@end

@implementation UIFXView
- (id)initWithFrame:(CGRect)frame
{
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [EAGLContext setCurrentContext:context];
    self = [super initWithFrame:frame context:context];
    if (self) {

        self.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
        self.drawableDepthFormat = GLKViewDrawableDepthFormat24;
        self.drawableMultisample = GLKViewDrawableMultisample4X;
        self.contentScaleFactor = [UIScreen mainScreen].scale;

        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        self.delegate = self;
        self.userInteractionEnabled = NO;
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(display)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        [self animate:NO];
    }
    return self;
}

#pragma mark - GLKViewDelegate methods
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.f, 0.f, 0.f, .0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    [self.effect render];
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
        [self display];
        [self animate:YES];
    } else {
        [self animate:NO];
    }
    self.hidden = !show;

}

#pragma mark - Private
- (void)animate:(BOOL)animate
{
    self.displayLink.paused = !animate;
}

@end
