//
//  PointableCursor.h
//  leapsynth
//
//  Created by Wiggins on 10/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointableCursor : NSObject
{
    int32_t pointableId;
    float x,y;
    float depth;
    NSColor *color;
    BOOL present;
}

@property (assign) int32_t pointableId;
@property (assign) float x;
@property (assign) float y;
@property (assign) float depth;
@property (assign) BOOL present;
@property (retain)  NSColor *color;


@end
