//
//  LeapSlider.m
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "LeapSlider.h"

@implementation LeapSlider

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        trackImage = [NSImage imageNamed:@"slider_bg.png"];
        knobImage = [NSImage imageNamed:@"slider_knob.jpg"];        
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGRect bounds = [self bounds];
    [trackImage drawInRect:bounds
                  fromRect:NSMakeRect(0,0, [trackImage size].width, [trackImage size].height)
                 operation:NSCompositeSourceOver
                  fraction:1.0];
    
    
    NSSize knobSize = [knobImage size];
    [knobImage drawInRect:NSMakeRect(bounds.size.width/2 - knobSize.width/2, 
                                     (bounds.size.height-knobSize.height)*_value, 
                                     knobSize.width, knobSize.height)
                 fromRect:NSMakeRect(0,0, knobSize.width, knobSize.height)
                operation:NSCompositeSourceOver
                 fraction:1.0];
     
    // Drawing code here.
}


//input events
- (void)mouseDown: (NSEvent *)event
{
    
}

- (void)onFrame:(NSNotification *)notification
{
    
}



- (double)doubleValue
{
    return _value;
}

- (void)setDoubleValue:(double)value
{
    value = MAX(value, 0);
    value = MIN(value, 1);
    _value = value;
    [self setNeedsDisplay:YES];
}

- (void)setTarget: (id)anObject
{
    _target = anObject;
}

- (id)target
{
    return _target;
}

- (void)setAction: (SEL)aSelector
{
    _action = aSelector;
}

- (SEL)action
{
    return _action;
}

@end
