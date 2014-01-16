//
//  GameScene.h
//
//  Base class for the different game scenes.
//

#import "GameScene.h"

@implementation GameScene

@synthesize _pGameData;
@synthesize _pSkyLayer;
@synthesize _pPlanetLayer;
@synthesize _pParticleLayer;
@synthesize _pGodsLayer;

-(id)init
{
    if (self = [super init])
    {
        _pSkyLayer = [SkyLayer node];
        _pPlanetLayer = [PlanetLayer node];
        _pParticleLayer = [ParticleLayer node];
        _pGodsLayer = [GodsLayer node];
    }
    return self;
}

@end
