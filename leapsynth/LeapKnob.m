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
//    [rotate rotateByDegrees:360*_value];
    [rotate rotateByRadians:angleInRadians];
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
    LeapController *leap = (LeapController *)[notification object];
    LeapFrame *frame = [leap frame:0];
    
    BOOL is_pressed = NO;
    
    NSArray *pointers = [frame pointables];
    for (int i=0; i < [pointers count]; i++) {
        LeapPointable *pointer = [pointers objectAtIndex:i];
        if ([pointer touchDistance] <= 0) {
            is_pressed = YES;
        }
    }
    
    if (!is_pressed) {
        lastFrame = nil;
        return;
    }
    
    if (lastFrame) {
        if ([[frame hands] count] != 0) {
            for (LeapHand *hand in [frame hands]) {
                float rot = [hand rotationAngle:lastFrame axis:LeapVector.zAxis];
                angleInRadians -= rot;
                
            
                NSLog(@"rot %f", rot);
                [self setNeedsDisplay:YES];
            }
        }
    }
    lastFrame = frame;
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
    
    angleInRadians = (2*M_PI) * _value;
    [self setNeedsDisplay:YES];
}

@end
