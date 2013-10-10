//
//  CursorOverlay.m
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
#import "CursorOverlay.h"

@implementation CursorOverlay

@synthesize showOnlyForemost;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        cursors = [[NSMutableDictionary alloc] initWithCapacity:5];
        showOnlyForemost = YES;
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{    
    NSEnumerator *enumerator = [cursors objectEnumerator];
    id value;
    while ((value = [enumerator nextObject])) {
        PointableCursor *cursor = (PointableCursor *)value;
        NSBezierPath *path = [[NSBezierPath alloc] init];
        [path appendBezierPathWithOvalInRect:NSMakeRect([cursor x],[cursor y],20,20)];
        [[cursor color] set];
        [path fill];
    }
}

- (float)randFloat
{
    return arc4random() % 11 * 0.1;
}

- (void)onFrame:(NSNotification *)notification
{
    LeapController *leap = (LeapController *)[notification object];
    LeapFrame *frame = [leap frame:0];
    
    //mark all pointables as dirty
    NSEnumerator *enumerator = [cursors objectEnumerator];
    id value;
    while ((value = [enumerator nextObject])) {
        PointableCursor *cursor = (PointableCursor *)value;
        [cursor setPresent:NO];
    }
    
    
    NSArray *pointables = [frame pointables];

    if (showOnlyForemost) {
        [self addPointable:[pointables frontmost] inFrame:frame];
    }
    else {
        for (int i=0; i < [pointables count]; i++) {
            [self addPointable:[pointables objectAtIndex:i] inFrame:frame];
        }
         
    }
            
    
    //remove any unused pointables
    for (id key in [cursors allKeys]) {
        PointableCursor *cursor = [cursors objectForKey:key];
        if (![cursor present]) {
            [cursors removeObjectForKey:key];
        }
    }
    
    [self setNeedsDisplay:YES];
    
}
- (void)addPointable:(LeapPointable*)pointable inFrame:(LeapFrame*)frame
{

    LeapVector *tip = [pointable stabilizedTipPosition];
    LeapVector *normalized = [[frame interactionBox] normalizePoint:tip clamp:NO];

    NSNumber *pointable_id = [NSNumber numberWithInt:[pointable id]];
    PointableCursor *cursor = [cursors objectForKey:pointable_id];
    if (!cursor) {
        cursor = [PointableCursor alloc];
        [cursor setPointableId:[pointable id]];
        [cursor setColor:[NSColor colorWithSRGBRed:[self randFloat] green:[self randFloat] blue:[self randFloat] alpha:1.0]];
        [cursors setObject:cursor forKey:pointable_id];
    }

    [cursor setPresent:YES];
    [cursor setX:normalized.x * _window.frame.size.width];
    [cursor setY:normalized.y * _window.frame.size.height];
    [cursor setDepth:[pointable touchDistance]];
    [cursor setColor:[[cursor color] colorWithAlphaComponent:1.0 - [cursor depth]]];
}

@end
