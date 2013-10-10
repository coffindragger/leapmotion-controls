//
//  CursorOverlay.h
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "PointableCursor.h"


@interface CursorOverlay : NSView
{
    NSMutableDictionary *cursors;
    BOOL showOnlyForemost;
}

@property (assign) BOOL showOnlyForemost;

@end
