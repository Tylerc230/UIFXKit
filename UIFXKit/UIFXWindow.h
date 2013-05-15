//
//  UIGLWindow.h
//  UIGLKit
//
//  Created by Tyler Casselman on 10/30/12.
//
//

#import <UIKit/UIKit.h>
#import "UIFXBaseEffect.h"
@interface UIFXWindow : UIWindow
@property (nonatomic, strong) UIFXBaseEffect *effect;
typedef void (^TransitionStartCallback)();
+ (UIFXWindow *)keyWindow;
- (void)startTransition:(TransitionStartCallback)transitionStarted;
- (void)endTransition;
- (BOOL)showingTransition;
@end
