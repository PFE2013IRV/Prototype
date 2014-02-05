//
//  PlanetLayer.m
//
//  The layer that contains the planet.
//
//

#import "PlanetLayer.h"
#import "GlobalConfig.h"

@implementation PlanetLayer

@synthesize pPlanetSprite = _pPlanetSprite;
@synthesize _positionBeforeZoom;
@synthesize _isZooming;
@synthesize _scalingFactor;

-(id)init
{
    if (self = [super init])
    {
        // Il faut mettre l'image de la planet. Il faut uniquement faire ça car la planet
        // est utilisé dans deux vues différentes
        // Pour faire d'autres actions il faut le faire grâce a des appels de méthode
        
        _pPlanetSprite = [[[CCSprite alloc] initWithFile:@"planet.png"] autorelease];
        _pPlanetSprite.anchorPoint = ccp(0.5,1.0);
        [_pPlanetSprite setPosition:CGPointMake(384, 250)];
        
        [self addChild:_pPlanetSprite];
    }
    return self;
}


-(void)launchBalanceModeForPlanet
{
    
    // Rescale du planet sprite (temporaire, pour soutenance PFE N°3)
    [_pPlanetSprite setScale:0.4];
    _pPlanetSprite.anchorPoint = ccp(0.5,0.5);
    CGPoint pos = _pPlanetSprite.position;
    pos.y -= 135.0f;
    _pPlanetSprite.position = pos;
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    
    [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryCorrectedZVertical toQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        
        CGFloat x = motion.gravity.x;
        CGFloat y = motion.gravity.y;
        
        CGFloat angle = atan2(y, x) + M_PI_2;           // in radians
        CGFloat angleDegrees = angle * 180.0f / M_PI;
        
        [self rotatePlanet:angleDegrees];
    
    }];
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

-(void) zoomInPlanet:(float) i_scalingFactor  withEndYPosition: (float) i_endYPosition
{
    
    [self stopAllActions];
    
    _scalingFactor = i_scalingFactor;
    
    _isZooming = YES;
    _positionBeforeZoom = self.position;
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    
    self.anchorPoint = ccp(0.5f,1.0f);
    CGPoint ZoomOutPosition = _positionBeforeZoom;
    ZoomOutPosition.y = i_endYPosition;
    
    id zoomIn = [CCScaleTo actionWithDuration:0.5f scale:_scalingFactor];
    id moveTo = [CCMoveTo actionWithDuration:0.5f position:ZoomOutPosition];
    id reset = [CCCallBlock actionWithBlock:^{ _isZooming = NO; }];
    id sequence = [CCSequence actions:zoomIn,reset,moveTo,nil];
    
    [self runAction:sequence];
    
}

-(void) zoomOutPlanet:(ccTime)delta
{
    // just to be sure no other actions interfere
    [self stopAllActions];
    
    _isZooming = YES;
    
    self.anchorPoint = ccp(0.5f,0.5f);
    
    id zoomOut = [CCScaleTo actionWithDuration:0.5f scale:1];
    id moveTo = [CCMoveTo actionWithDuration:0.5f position:_positionBeforeZoom];
    
    id reset = [CCCallBlock actionWithBlock:^{
        CCLOG(@"zoom in/out complete");
        _isZooming = NO;
    }];
    id sequence = [CCSequence actions:zoomOut,reset,moveTo,nil];
    [self runAction:sequence];
    
    
    
}

-(void) update:(ccTime)delta
{
    
    if (_isZooming)
    {
        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        CGPoint screenCenter = CGPointMake(screenSize.width * 0.5f,
                                           screenSize.height * 0.5f);
        
        CGPoint offsetToCenter = ccpSub(screenCenter, self.position);
        self.position = ccpMult(offsetToCenter, self.scale);
        self.position = ccpSub(self.position, ccpMult(offsetToCenter,
                                                      (_scalingFactor - self.scale) /
                                                      (_scalingFactor - 1.0f)));
    }
}

@end
