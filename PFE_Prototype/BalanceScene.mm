//
//  BalanceScene.m
//
//  The tower balance game scene
//

#import "BalanceScene.h"
#import "IntroScene.h"
#import "TowerAndPlanetLayer.h"


@implementation BalanceScene

@synthesize previusScene = _previusScene;
@synthesize _pTowerAndPlanetLayer;
@synthesize pPlanetLayer = _pPlanetLayer;
@synthesize _pHUD;

//`-(id) initGameScene : (GameData*) i_pGameData CurrentBackground :(CCSprite*) i_CurrentBackground
-(id) initGameScene : (GameData*) i_pGameData CurrentBackground :(CCSprite*) i_CurrentBackground //CurrenPlanet : (PlanetLayer*) planetLayer
{
    if(!i_pGameData)
    {
        NSLog(@"Fatal error : constructions scene init failed");
    }
    else if (self = [super init])
    {
        
        self._pGameData = i_pGameData;
        //self.planet = planetLayer;
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
            [self._pSunLayer ManageSunBalance];
            [self addChild:self._pSunLayer];
            
        }
        
        
       
        
        TowerAndPlanetLayer *pTowerAndPlanet = [[[TowerAndPlanetLayer alloc] initWithGameData:i_pGameData PlanetLayer:self._pPlanetLayer] autorelease];
        [self addChild:pTowerAndPlanet];
        
        if(!SIMULATOR_MODE)
        {
            CloudsFrontTop* pCloudsFrontTop = [[CloudsFrontTop alloc] init];
            [self addChild:pCloudsFrontTop];
        }
        
        _pHUD = [[HUDLayer alloc] init];
        [self addChild:_pHUD];
        
        [self schedule:@selector(endGame)interval:TIME_FOR_BALANCE];
        
    }
    
    return self;
}

-(void) endGame
{
    
    UIAlertView* popUpEnd = [[UIAlertView alloc] initWithTitle:@"Fin du jeu !" message:@"Félicitation vous avez terminé la partie !" delegate:self cancelButtonTitle:@"Revenir au menu" otherButtonTitles:nil];
    [popUpEnd show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5 scene:[[[IntroScene alloc] init] autorelease]]];}

-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}


@end
