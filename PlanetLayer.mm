//
//  PlanetLayer.m
//
//  The layer that contains the planet.
//
//

#import "PlanetLayer.h"


@implementation PlanetLayer

@synthesize pPlanetSprite = _pPlanetSprite;
@synthesize degreesRotation = _degreesRotation;


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
    
    [self schedule:@selector(rotatePlanet) interval:2.00];
    _degreesRotation = 0;
}

-(void)stopBalanceModeForPlanet
{
    //[self unscheduleUpdate];
    
    [self unschedule:@selector(rotatePlanet)];
}

-(void)rotate:(int) degrees
{
    if (degrees >= 360)
    {
        [self stopBalanceModeForPlanet];
    }
    
    _degreesRotation = degrees % 360;
    _pPlanetSprite.rotation = _degreesRotation;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(hasRotate:)])
    {
        [self.delegate hasRotate:_degreesRotation];
    }
    
    
}

-(void)update:(ccTime)delta
{
    
}

-(void)rotatePlanet
{
    [self rotate:_degreesRotation + 5];
}

@end
