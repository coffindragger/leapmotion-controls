//
//  LeapKnob.h
//  leapsynth
//
//  Created by Wiggins on 10/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LeapKnob : NSControl
{
    double _value;
    id _target;
    SEL _action;

    NSImage *knobImage;
}
@end
