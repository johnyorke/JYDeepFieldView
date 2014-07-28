//
//  TOCMotionEffectsEngine.h
//  TecniqTV
//
//  Created by John Yorke on 01/04/2014.
//  Copyright (c) 2014 Somewhat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOCMotionEffectsEngine.h"

@implementation TOCMotionEffectsEngine
void Swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}


BOOL swizzeledMotionEffectsAreSupported() {
    return YES;
}

void swizzledBeginSuspendingForReasonImp (id self, SEL _cmd, NSString *reason) {
    if ([reason isEqualToString:@"mirroringMainScreen"]) {
        return;
    }
    [self performSelector:NSSelectorFromString(@"swizzledBeginSuspendingForReason:") withObject:reason];
}


+ (void)load {
    Class motionEffectsEngine = NSClassFromString(@"_UIMotionEffectEngine");
    if (!motionEffectsEngine) {
        return;
    }
    SEL swizzledBeginSuspendingForReasonSel = NSSelectorFromString(@"swizzledBeginSuspendingForReason:");
    class_addMethod(motionEffectsEngine, swizzledBeginSuspendingForReasonSel, (IMP)swizzledBeginSuspendingForReasonImp, "v@:@");
    
    Swizzle(motionEffectsEngine, NSSelectorFromString(@"beginSuspendingForReason:"), swizzledBeginSuspendingForReasonSel);
    
    SEL swizzeledSupportedSel = NSSelectorFromString(@"_motionEffectsAreSupportedSwizzeled");
    
    Swizzle(motionEffectsEngine, NSSelectorFromString(@"_motionEffectsAreSupported"), swizzeledSupportedSel);
    
}

@end