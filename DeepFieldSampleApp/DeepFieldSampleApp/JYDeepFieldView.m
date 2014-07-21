//
//  JYDeepFieldView.m
//  
//
//  Created by John Yorke on 16/07/2014.
//
//

#import "JYDeepFieldView.h"

static const float kBackImageMotionValue = 75;
static const float kMiddleImageMotionValue = 50;
static const float kFrontImageMotionValue = 25;

@interface JYDeepFieldView ()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *frontImageView;

@end

@implementation JYDeepFieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backImageView = [[UIImageView alloc] initWithFrame:frame];
        self.middleImageView = [[UIImageView alloc] initWithFrame:frame];
        self.frontImageView = [[UIImageView alloc] initWithFrame:frame];
        
        NSArray *views = @[self.backImageView,self.middleImageView,self.frontImageView];
        
        for (UIImageView *imageView in views) {
            
            float motionValue = 0;
            
            if (imageView == self.backImageView) 
            {
                motionValue = kBackImageMotionValue;
                [imageView setContentMode:UIViewContentModeScaleAspectFill];
                
            } else {
                if (imageView == self.middleImageView) motionValue = kMiddleImageMotionValue;
                if (imageView == self.frontImageView) motionValue = kFrontImageMotionValue;
                
                [imageView setContentMode:UIViewContentModeCenter];
            }
            
            imageView.bounds = CGRectMake(frame.origin.x - kBackImageMotionValue,
                                          frame.origin.y - kBackImageMotionValue,
                                          frame.size.width + (kBackImageMotionValue*2),
                                          frame.size.height + (kBackImageMotionValue*2));
        }
        
        
        [self addSubview:self.backImageView];
        [self insertSubview:self.middleImageView aboveSubview:self.backImageView];
        [self insertSubview:self.frontImageView aboveSubview:self.middleImageView];
    }
    
    return self;
}

- (void)addMotionEffectToView:(UIView *)view withValue:(float)value
{
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-value);
    horizontalMotionEffect.maximumRelativeValue = @(value);
    
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-value);
    verticalMotionEffect.maximumRelativeValue = @(value);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [view addMotionEffect:group];
}

- (UIImage *)backImage
{
    return self.backImageView.image;
}

- (UIImage *)middleImage
{
    return self.middleImageView.image;
}

- (UIImage *)frontImage
{
    return self.frontImageView.image;
}

- (void)setBackImage:(UIImage *)backImage
{
    self.backImageView.image = backImage;
    
    [self addMotionEffectToView:self.backImageView withValue:kBackImageMotionValue];
}

- (void)setMiddleImage:(UIImage *)middleImage
{
    self.middleImageView.image = middleImage;
    
    [self addMotionEffectToView:self.middleImageView withValue:kMiddleImageMotionValue];
}

- (void)setFrontImage:(UIImage *)frontImage
{
    self.frontImageView.image = frontImage;
    
    [self addMotionEffectToView:self.frontImageView withValue:kFrontImageMotionValue];
}

@end
