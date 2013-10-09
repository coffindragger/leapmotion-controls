//
//  LeapSlider.h
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LeapSlider : NSControl
{
    double _value;
    id _target;
    SEL _action;
    
    NSImage *trackImage;
    NSImage *knobImage;
}

- (void)setDoubleValue:(double)value;
- (double)doubleValue;
@end
