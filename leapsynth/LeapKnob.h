//
//  LeapKnob.h
//  leapsynth
//
//  Created by Wiggins on 10/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"

@interface LeapKnob : NSControl
{
    double _value;
    id _target;
    SEL _action;
    
    double angleInRadians;
    NSImage *knobImage;

    LeapFrame *lastFrame;
}

- (void)onFrame:(NSNotification *)notification;

@end
