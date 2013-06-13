//
//  ContinuousEffectViewController.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "ContinuousEffectViewController.h"
#import "UIFXView.h"
#import "UIView+ImageRender.h"
#import "PRTween.h"

@interface ContinuousEffectViewController ()
@property (nonatomic, strong) IBOutlet UIView *view1;
@property (nonatomic, strong) IBOutlet UIView *view2;
@property (nonatomic, strong) IBOutlet UIFXView *effectView;
@end

@implementation ContinuousEffectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.effectView setEffect:self.effect];
    self.effectView.backgroundGLColor = kWhiteColor;
}

- (void)viewWillAppear:(BOOL)animated
{
}

#pragma mark - Public methods
#pragma mark - IBActions
- (IBAction)sliderTapped:(UISlider *)sender
{
    [self setSnapShots];
    [self.effectView showEffect:YES];
}

- (IBAction)sliderValueChanged:(UISlider *)slider
{
    self.effect.progress = slider.value;
}

- (IBAction)sliderValueReleased:(UISlider *)slider
{
    float progress = slider.value;
    float end = slider.value > .5f ? 1.f : 0.f;
    PRTweenPeriod *period = [PRTweenPeriod periodWithStartValue:progress endValue:end duration:.5f];
    PRTweenOperation *operation = [[PRTweenOperation alloc] init];
    operation.period = period;
    operation.updateBlock = ^(PRTweenPeriod *tweenPeriod, BOOL *stop)
    {
        float currentProgress = tweenPeriod.tweenedValue;
        slider.value = currentProgress;
        self.effect.progress = currentProgress;
    };
    operation.completeBlock = ^(BOOL finish)
    {
        BOOL showDest = end > .5f;
        self.view2.hidden = !showDest;
        self.view1.hidden = showDest;
        [self.effectView showEffect:NO];
    };
    [[PRTween sharedInstance] addTweenOperation:operation];
    
}

#pragma mark - Private method
- (void)setSnapShots
{
    BOOL view1Hidden = self.view1.hidden;
    BOOL view2Hidden = self.view2.hidden;

    self.view1.hidden = NO;
    self.view2.hidden = NO;
    [self.effect setSourceSnapshot:[self.view1 snapshot]];
    [self.effect setDestSnapshot:[self.view2 snapshot]];
    
    self.view1.hidden = view1Hidden;
    self.view2.hidden = view2Hidden;

}

@end
