//
//  AppDelegate.m
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize slider1;
@synthesize cursorOverlay;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    leapController = [[LeapController alloc] init];
    [leapController addListener:self];
    
    [leapController addListener:cursorOverlay];
}


- (void)onConnect:(NSNotification *)notification
{
    [leapController enableGesture:LEAP_GESTURE_TYPE_KEY_TAP enable:YES];
    [leapController enableGesture:LEAP_GESTURE_TYPE_SCREEN_TAP enable:YES];
    
    NSLog(@"Connect!");
    
}

- (void)onDisconnect:(NSNotification *)notification
{
}

- (void)onFrame:(NSNotification *)notification
{
    LeapController *leap = (LeapController *)[notification object];
    LeapFrame *frame = [leap frame:0];
    
    if ([[frame pointables] count] > 0) {
        LeapPointable *pointer = [[frame pointables] frontmost];
        LeapVector *tip = [pointer stabilizedTipPosition];
        LeapVector *normalized = [[frame interactionBox] normalizePoint:tip clamp:YES];
        float x = normalized.x * _window.frame.size.width; 
        float y = _window.frame.size.height - normalized.y * _window.frame.size.height;
    }
    
    
//    if ([[frame hands] count] != 0) {
//        
//        for (LeapHand *hand in [frame hands]) {
//            int32_t hand_id = [hand id];
//            LeapVector *pos = [hand palmPosition];
//            
//            //todo: hands
//        }
//    }
    
    NSArray *gestures = [frame gestures:nil];
    for (int i = 0; i < [gestures count]; i++) {
        LeapGesture *gesture = [gestures objectAtIndex:i];
        for (LeapHand *hand in [gesture hands]) {
            int32_t hand_id = [hand id];
            LeapVector *pos = [hand palmPosition];
            
            //todo: gestures
        }
    }
}

@end
