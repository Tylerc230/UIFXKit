//
//  UIGLView.h
//  UIGLKit
//
//  Created by Tyler Casselman on 10/30/12.
//
//

#import <UIKit/UIKit.h>
#import "UIFXBaseEffect.h"

@interface UIFXView : GLKView
@property (nonatomic, strong) UIImage *snapshot;
@property (nonatomic, strong) UIFXBaseEffect *effect;
- (void)showEffect:(BOOL)show;
@end
