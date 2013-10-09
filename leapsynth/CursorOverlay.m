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
    
    NSBezierPath *path = [[NSBezierPath alloc] init];
//    [path appendBezierPathWithOvalInRect:NSMakeRect(100,100,50,50)];
    
    NSEnumerator *enumerator = [cursors objectEnumerator];
    id value;
    while ((value = [enumerator nextObject])) {
        PointableCursor *cursor = (PointableCursor *)value;
        [path appendBezierPathWithOvalInRect:NSMakeRect([cursor x],[cursor y],20,20)];

    }
    [path fill];
}


- (void)onFrame:(NSNotification *)notification
{
    LeapController *leap = (LeapController *)[notification object];
    LeapFrame *frame = [leap frame:0];
    
    NSArray *pointers = [frame pointables];
    [cursors removeAllObjects];
    for (int i=0; i < [pointers count]; i++) {
        LeapPointable *pointer = [pointers objectAtIndex:i];
        LeapVector *tip = [pointer stabilizedTipPosition];
        LeapVector *normalized = [[frame interactionBox] normalizePoint:tip clamp:YES];
        
        NSNumber *pointer_id = [NSNumber numberWithInt:[pointer id]];
        PointableCursor *cursor = [cursors objectForKey:pointer_id];
        if (!cursor) {
            cursor = [PointableCursor alloc];
            [cursor setPointableId:[pointer id]];
            [cursors setObject:cursor forKey:pointer_id];
        }
        
        [cursor setX:normalized.x * _window.frame.size.width];
        [cursor setY:normalized.y * _window.frame.size.height];
        [cursor setDepth:[pointer touchDistance]];
    }
    [self setNeedsDisplay:YES];
    
}
@end
