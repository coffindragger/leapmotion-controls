//
//  CursorOverlay.m
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//
#import "CursorOverlay.h"

@implementation CursorOverlay

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        cursors = [[NSMutableDictionary alloc] initWithCapacity:5];
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
    
    NSArray *pointers = [frame pointables];
    for (int i=0; i < [pointers count]; i++) {
        LeapPointable *pointer = [pointers objectAtIndex:i];
        LeapVector *tip = [pointer stabilizedTipPosition];
        LeapVector *normalized = [[frame interactionBox] normalizePoint:tip clamp:YES];
        
        NSNumber *pointer_id = [NSNumber numberWithInt:[pointer id]];
        PointableCursor *cursor = [cursors objectForKey:pointer_id];
        if (!cursor) {
            cursor = [PointableCursor alloc];
            [cursor setPointableId:[pointer id]];
            [cursor setColor:[NSColor colorWithSRGBRed:[self randFloat] green:[self randFloat] blue:[self randFloat] alpha:1.0]];
            [cursors setObject:cursor forKey:pointer_id];
        }
        
        [cursor setPresent:YES];
        [cursor setX:normalized.x * [self bounds].size.width];
        [cursor setY:normalized.y * [self bounds].size.height];
        [cursor setDepth:[pointer touchDistance]];
        [cursor setColor:[[cursor color] colorWithAlphaComponent:1.0 - [cursor depth]]];
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
@end
