//
//  CCRotationAround.m
//  Cube
//
//  Created by Maximilien on 12/10/13.
//  Copyright (c) 2013 Alexandre Jegouic. All rights reserved.
//

#import "CCRotationAround.h"

@implementation CCRotationAround
+(id) actionWithDuration: (ccTime) t position: (CGPoint) pos radius: (ccTime) h direction: (int) dir rotation: (ccTime) rot angle: (float) ang
{
    return [[[self alloc] initWithDuration: t position: pos radius: h direction: dir rotation: rot angle: ang] autorelease];
}

-(id) initWithDuration: (ccTime) t position: (CGPoint) pos radius: (ccTime) h direction: (int) dir rotation: (ccTime) rot angle: (float) ang
{
    if( (self=[super initWithDuration:t]) ) {
        center = pos;
        radius = h;
        direction = dir;
        rotation = rot;
        angle = ang;
    }
    return self;
}

-(id) copyWithZone: (NSZone*) zone
{
    CCAction *copy = [[[self class] allocWithZone: zone] initWithDuration: [self duration] position: center radius: radius direction: direction rotation: rotation angle: angle];
    return copy;
}

-(void) startWithTarget:(id)aTarget
{
    [super startWithTarget:aTarget];
}

-(void) update: (ccTime) t
{
    currentAngle =  M_PI * t * direction + angle; //2pi rad for 360 degrees
    [_target setPosition: ccpAdd(ccpMult(ccpForAngle(-currentAngle*rotation), radius), center)];
    [_target setRotation: rotation];
    
}

-(CCActionInterval*) reverse
{
    return [[self class] actionWithDuration:_duration position:center radius:radius direction:-direction rotation:rotation angle: angle];
}

@end