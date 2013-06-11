//
//  ContinuousEffectViewController.m
//  UIFXKit
//
//  Created by Tyler Casselman on 6/11/13.
//  Copyright (c) 2013 Casselman Consulting. All rights reserved.
//

#import "ContinuousEffectViewController.h"
#import "UIFXView.h"

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
}

#pragma mark - Public methods
#pragma mark - IBActions
- (IBAction)sliderTapped:(UISlider *)sender
{
    [self.effectView showEffect:YES];
}

- (IBAction)sliderValueChanged:(UISlider *)slider
{
    self.effect.progress = slider.value;
}

- (IBAction)sliderValueReleased:(UISlider *)slider
{
    [self.effectView showEffect:NO];
}

@end
