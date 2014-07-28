JYDeepFieldView
===============

<img src="https://raw.githubusercontent.com/johnyorke/JYDeepFieldView/master/images/deep_field.gif">

# Intro

JYDeepFieldView is an easy way to create a 3D parallax effect using 3 stacked UIImageViews. Ideal for use on intro screens or when you really want to bring an image to life.

# Usage

I've included a .psd that makes it easy to preview what your deep field image will look like. I suggest 790x1286 for a 4" screen (standard resolution + 150 to compensate for parallax movement). You'll need 3 images - a back, middle and front image.

**Back** - Ideally no transparency as this serves as the background. It has +/- 75 pixels of movement applied to it based on device motion.
**Middle** - Serves as the middle-ground. Can have transparency. It has +/- 50 pixels of movement applied to it based on device motion.
**Front** - The image that sits "closest" to the user. It has +/- 25 pixels of movement applied to it based on device motion.

In Photoshop, postion your 3 images paying careful attention to their order (see layer names). When you're finished go to **File > Scripts > Export Layers to Files...**.

In your Xcode project:

1. Import JYDeepFieldView .h and .m
2. Init a JYDeepFieldView 
3. Drop your 3 exported images from Photoshop into Images.xcassets (back, middle and front)
4. Tell your JYDeepFieldView which image to use for each plane
5. Add your JYDeepFieldView as a subview to your view

You're done! This particular scene should now have a subtle 3D effect applied to it that moves each plane at slightly different speeds.

# Code Example

```obj-c
- (void)viewWillAppear
{
    [super viewWillAppear:animated];
    
    JYDeepFieldView *deepField = [[JYDeepFieldView alloc] initWithFrame:self.view.frame];
    
    deepField.backImage = [UIImage imageNamed:@"back"];
    deepField.middleImage = [UIImage imageNamed:@"middle"];
    deepField.frontImage = [UIImage imageNamed:@"front"];
    
    [self.view addSubview:deepField];
}
``` 

# TODO

1. Make it work for varying view sizes.
2. Make the different movement values configurable.
3. Other cool stuff.
