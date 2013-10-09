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
}

@property (assign) int32_t pointableId;
@property (assign) float x;
@property (assign) float y;
@property (assign) float depth;

@end
