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
@synthesize _pWindGodLayer;
@synthesize _pDustLayer;
@synthesize _pStarsLayer;

-(id)init
{
    if (self = [super init])
    {
        _pGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
        
        _pSkyLayer = [SkyLayer node];
        _pPlanetLayer = [PlanetLayer node];
        _pWindGodLayer = [WindGodLayer node];
        _pDustLayer = [DustLayer node];
        
        if(!SIMULATOR_MODE)
            _pSunLayer = [SunLayer node];
            _pStarsLayer = [[StarsLayer alloc] init];
    }
    return self;
}

@end
