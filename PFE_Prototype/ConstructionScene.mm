//
//  ConstructionScene.m
//
//  The construction game scene
//

#import "ConstructionScene.h"


@implementation ConstructionScene

@synthesize _pElementGodsLayer;
@synthesize _pFireAttackLayer;
@synthesize _pWindAttackLayer;
@synthesize pMenuAndTowerLayer = _pMenuAndTowerLayer;
@synthesize _pGodWrathLayer;


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
        _pGodWrathLayer = [GodWrathLayer node];
        _pMenuAndTowerLayer = [[[MenuAndConstructionTowerLayer alloc] initWithTowerData:i_pGameData._pTowerData] autorelease];
        
        self._pGameData = i_pGameData;
        
        [self._pSkyLayer ManageBackgroundConstruction];
        [self addChild:self._pSkyLayer];
        
        [self._pSunLayer ManageSunConstruction];
        
        [self addChild:self._pDustLayer];
        [self addChild:self._pSunLayer];
        [self addChild:self._pGodWrathLayer];
        [self addChild:self._pPlanetLayer];
        [self addChild:self._pElementGodsLayer];
        [self addChild:self._pWindGodLayer];
        [self addChild:self._pFireAttackLayer];
        [self addChild:self._pWindAttackLayer];
        
        
        CCSprite* pBordersSprite = [[CCSprite alloc] initWithFile:@"borders.png"];
        pBordersSprite.anchorPoint = ccp(0.0f,0.0f);
        pBordersSprite.position = ccp(0.0f,0.0f);
        [self addChild:pBordersSprite];
        
        [self addChild:_pMenuAndTowerLayer];
        
        
        ////////////////////////////////////////////////////////////////
        ///////     AJOUT TEMPORAIRE - bordures du HUD
        
        
        ////////////////////////////////////////////////////////////////
        
        
        // add light on tower column (particle)
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
