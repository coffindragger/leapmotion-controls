//
//  LeapKnob.m
//  leapsynth
//
//  Created by Wiggins on 10/9/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "LeapKnob.h"

@implementation LeapKnob

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        knobImage = [NSImage imageNamed:@"pot_knob.png"];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGRect bounds = [self bounds];
    NSAffineTransform *rotate = [[NSAffineTransform alloc] init];
    NSGraphicsContext *context = [NSGraphicsContext currentContext];
        
    [context saveGraphicsState];

    [rotate translateXBy:bounds.size.width/2 yBy:bounds.size.height/2];
    [rotate rotateByDegrees:360*_value];
    [rotate translateXBy:-(bounds.size.width/2) yBy:-(bounds.size.height/2)];
    [rotate concat];
    
    [knobImage drawInRect:bounds
                  fromRect:NSMakeRect(0,0, [knobImage size].width, [knobImage size].height)
                 operation:NSCompositeSourceOver
                  fraction:1.0];
    
    [context restoreGraphicsState];
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

@end
