//
//  PlanetLayer.m
//
//  The layer that contains the planet.
//
//

#import "PlanetLayer.h"


@implementation PlanetLayer

@synthesize pPlanetSprite = _pPlanetSprite;


-(id)init
{
    if (self = [super init])
    {
        // Il faut mettre l'image de la planet. Il faut uniquement faire ça car la planet
        // est utilisé dans deux vues différentes
        // Pour faire d'autres actions il faut le faire grâce a des appels de méthode
        
        _pPlanetSprite = [[[CCSprite alloc] initWithFile:@"planet.png"] autorelease];
        [_pPlanetSprite setPosition:CGPointMake(400, 200)];
        
        [self addChild:_pPlanetSprite];
    }
    return self;
}


-(void)launchBalanceModeForPlanet
{
    //[self scheduleUpdate];
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        CGFloat x = motion.gravity.x;
        CGFloat y = motion.gravity.y;
        
        CGFloat angle = atan2(y, x) + M_PI_2;           // in radians
        CGFloat angleDegrees = angle * 180.0f / M_PI;
        
        [self rotatePlanet:angleDegrees];
    
    }];
    _degreesRotation = 0;
    //[self scheduleUpdate];
}

-(void)stopBalanceModeForPlanet
{
    [motionManager stopDeviceMotionUpdates];
}

-(void)rotatePlanet:(CGFloat)rotation
{
    if (rotation > -85 && rotation < 90)
    {
        _pPlanetSprite.rotation = rotation / 2;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(hasRotate:)])
        {
            [self.delegate hasRotate:rotation / 2];
        }
    }
}

@end
