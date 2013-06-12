//
//  UIGLView.h
//  UIGLKit
//
//  Created by Tyler Casselman on 10/30/12.
//
//

#import <UIKit/UIKit.h>
#import "UIFXBaseEffect.h"

@interface UIFXView : GLKView <GLKViewDelegate>
@property (nonatomic, strong) UIImage *snapshot;
@property (nonatomic, strong) UIFXBaseEffect *effect;
@property (nonatomic, assign) GLKVector4 backgroundGLColor;
- (void)showEffect:(BOOL)show;
@end
