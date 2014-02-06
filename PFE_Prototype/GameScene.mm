//
//  GameScene.h
//
//  Base class for the different game scenes.
//

#import "GameScene.h"

@implementation GameScene

@synthesize _pGameData;
@synthesize _pSkyLayer;
@synthesize _pSunLayer;
@synthesize _pPlanetLayer;
@synthesize _pDustLayerBack;
@synthesize _pDustLayerFront;
@synthesize _pStarsLayer;


-(id)init
{
    if (self = [super init])
    {
        _pGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
        
        _pSkyLayer = [SkyLayer node];
        _pPlanetLayer = [PlanetLayer node];
        _pDustLayerFront = [DustLayerFront node];
        _pDustLayerBack = [DustLayerBack node];

        
        if(!SIMULATOR_MODE)
            _pSunLayer = [SunLayer node];
            _pStarsLayer = [[StarsLayer alloc] init];
    }
    return self;
}

@end
