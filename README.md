UIFXKit
=======
UIFXKit is a layer of OpenGL that sits on top of UIKit and allows OpenGL powered effects and transitions between views.

How it works
------------
Simply use UIFXWindow as your application window, pass in the UIBaseEffect subclass of your choosing or write your own. When an effect is triggered, the library takes a snap shot image of the current UIKit view heirarchy and uses that as a texture for the transition by wrapping it around a 3D model defined in the effect. From there it is up to the effect to determine what happens. You could make it appear like the UIKit UI folds up into a paper airplane, and flies away, you could write a shader to make it appear that the intface is on fire. Using OpenGL and shader technology anything is possible.
