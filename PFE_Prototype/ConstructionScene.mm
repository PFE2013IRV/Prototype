//
//  ConstructionScene.m
//
//  The construction game scene
//

#import "ConstructionScene.h"


@implementation ConstructionScene


-(id) initGameScene : (GameData*) i_pGameData
{
    if(!i_pGameData)
    {
        NSLog(@"Fatal error : constructions scene init failed");
    }
    else if (self = [super init])
    {
        self._pGameData = i_pGameData;
        
        
        [self._pSkyLayer ManageBackgroundConstruction];
        [self addChild:self._pSkyLayer];
        
        [self._pSunLayer ManageSunConstruction];
        [self addChild:self._pSunLayer];
        //[self addChild:self._pPlanetLayer];
        //[self addChild:self._pGodsLayer];
       // [self addChild:self._pParticleLayer];
        
        
        [self scheduleUpdate];
    }
    
    return self;
}


-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

@end
