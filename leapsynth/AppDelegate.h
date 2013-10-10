//
//  AppDelegate.h
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"
#import "LeapSlider.h"
#import "CursorOverlay.h"
#import "LeapKnob.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    LeapController *leapController;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet LeapSlider *slider1;
@property (weak) IBOutlet CursorOverlay *cursorOverlay;
@property (weak) IBOutlet LeapKnob *knob1;

@end
