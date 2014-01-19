//
//  ConstructionScene.m
//
//  The construction game scene
//

#import "ConstructionScene.h"


@implementation ConstructionScene

@synthesize _pElementGodsLayer;
@synthesize pMenuAndTowerLayer = _pMenuAndTowerLayer;


-(id) initGameScene : (GameData*) i_pGameData
{
    if(!i_pGameData)
    {
        NSLog(@"Fatal error : constructions scene init failed");
    }
    else if (self = [super init])
    {
        
        _pElementGodsLayer = [ElementGodsLayer node];
        _pFireAttackLayer = [FireAttackLayer node];
        _pWindAttackLayer = [WindAttackLayer node];
        
        
        self._pGameData = i_pGameData;
        
        
        [self._pSkyLayer ManageBackgroundConstruction];
        [self addChild:self._pSkyLayer];
        
        [self._pSunLayer ManageSunConstruction];
        [self addChild:self._pSunLayer];
        [self addChild:self._pElementGodsLayer];
        [self addChild:self._pWindGodLayer];
        [self addChild:self._pFireAttackLayer];
        [self addChild:self._pWindAttackLayer];
        [self addChild:self._pDustLayer];
        
        
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
