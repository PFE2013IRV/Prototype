//
//  WindGodData.m
//
//
//  Model class for the wind god. Encapsulates several information
//  about his current state.
//

#import "WindGodData.h"

@implementation WindGodData

@synthesize _godIsUp;
@synthesize _windGodPosition;
@synthesize _godIsMoving;
@synthesize _godIsAttacking;

-(id) init
{
    if(self = [super init])
    {
        _godIsMoving = NO;
        _godIsUp = NO;
        _godIsAttacking = NO;
        _windGodPosition = CGPointMake(580, 232);
    }
    
    return self;
}


@end
