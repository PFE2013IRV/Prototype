//
//  BalanceScene.m
//
//  The tower balance game scene
//

#import "BalanceScene.h"
#import "TowerAndPlanetLayer.h"


@implementation BalanceScene

@synthesize previusScene = _previusScene;
@synthesize _pTowerAndPlanetLayer;

-(id) initGameScene : (GameData*) i_pGameData CurrentBackground :(CCSprite*) i_CurrentBackground CurrentSun  : (ccColor4B) i_CurrentSunColor
{
    if(!i_pGameData)
    {
        NSLog(@"Fatal error : constructions scene init failed");
    }
    else if (self = [super init])
    {
        self._pGameData = i_pGameData;
        
        [self._pSkyLayer ManageBackgroundBalance:i_CurrentBackground];
        [self addChild:self._pSkyLayer];
        
        StarsLayer* pStars = [[StarsLayer alloc] init];
        [self addChild:pStars];
        
        CGPoint positionBkg1 = ccp(580,700);
        CGPoint positionBkg2 = ccp(160,340);
        
        if(!SIMULATOR_MODE)
        {
            AnimatedBackground* pBkg1 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg1 withScale:0.5 withBeginDelay:20 withPlanetType:1];
            AnimatedBackground* pBkg2 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg2 withScale:1 withBeginDelay:10 withPlanetType:2];
            CloudsBack* pCloudsBack = [[CloudsBack alloc] init];
            [self addChild:pBkg1];
            [self addChild:pBkg2];
            [self addChild:pCloudsBack];
            [self._pSunLayer ManageSunBalance:i_CurrentSunColor];
            [self addChild:self._pSunLayer];
            
        }
     
         _pTowerAndPlanetLayer = [[[TowerAndPlanetLayer alloc] initWithGameData:i_pGameData PlanetLayer:self._pPlanetLayer] autorelease];
        _pTowerAndPlanetLayer.TowerSize = _previusScene._pMenuAndTowerLayer.pTowerLayer.currentHeightNoScroll;
        [self addChild:_pTowerAndPlanetLayer];
        
        if(!SIMULATOR_MODE)
        {
            CloudsFront* pCloudsFront = [[CloudsFront alloc] init];
            [self addChild:pCloudsFront];
        }
        
    }
    
    return self;
}



-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

-(void)onEnterTransitionDidFinish
{
  // [self returnToConstruction];
    
}
-(void)returnToConstruction
{
    //indexes des blocs qui se sont peter la gueule
  //  NSMutableIndexSet *indexes;
    //[_previusScene._pMenuAndTowerLayer.pTowerLayer removeBlocAtIndexes:indexes];
    [[CCDirector sharedDirector] popScene];
}
-(void)onEnter
{
 if(_previusScene._pWindGodLayer._pGodData._godIsUp)
 {
     self._pTowerAndPlanetLayer.balanceTower.WindAttackType = true;
 }
 else
 {
     self._pTowerAndPlanetLayer.balanceTower.WindAttackType = false;
 }
}


@end
