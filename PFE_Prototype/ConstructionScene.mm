//
//  ConstructionScene.m
//
//  The construction game scene
//

#import "ConstructionScene.h"
#import "BlocManager.h"
#import "GlobalConfig.h"
#import "HUDLayer.h"

@implementation ConstructionScene

@synthesize _pElementGodsLayer;
@synthesize _pFireAttackLayer;
@synthesize _pWindAttackLayer;
@synthesize _pUpsetGodParticleLayer;
@synthesize _pMenuAndTowerLayer;
@synthesize _pGodWrathLayer;
@synthesize _pBkg1;
@synthesize _pBkg2;


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
        _pUpsetGodParticleLayer = [UpsetGodParticleLayer node];
        _pGodWrathLayer = [GodWrathLayer node];
        _pMenuAndTowerLayer = [[[MenuAndConstructionTowerLayer alloc] initWithTowerData:i_pGameData._pTowerData HeightWin:i_pGameData.winHeight] autorelease];
        
        self._pGameData = i_pGameData;
        
        [self._pSkyLayer ManageBackgroundConstruction];
        
        // CIEL ET BACKGROUND

        
        _pFireAttackLayer.delegate = _pMenuAndTowerLayer.pTowerLayer;
        [self addChild:self._pSkyLayer];
        
        if(!SIMULATOR_MODE)
            [self addChild:self._pStarsLayer];
        
        [self._pSunLayer ManageSunConstruction];
        [self addChild:self._pDustLayer];
        
        if(!SIMULATOR_MODE)
        {
            CGPoint positionBkg1 = ccp(580,700);
            CGPoint positionBkg2 = ccp(100,270);
            _pBkg1 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg1 withScale:0.5 withBeginDelay:20 withPlanetType:1];
            _pBkg2 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg2 withScale:1 withBeginDelay:10 withPlanetType:2];
            [self addChild:_pBkg1];
            [self addChild:_pBkg2];
        }
        
        
        if(!SIMULATOR_MODE)
        {
            CloudsBack* pCloudsBack = [[CloudsBack alloc] init];
            [self addChild:pCloudsBack];
        
            [self addChild:self._pSunLayer];
            CloudsFront* pCloudsFront = [[CloudsFront alloc] init];
            [self addChild:pCloudsFront];
        }
        
        [self addChild:self._pGodWrathLayer];
        [self addChild:self._pUpsetGodParticleLayer];
        [self addChild:self._pElementGodsLayer];
        
        [self addChild:self._pWindAttackLayer];
        
        [self addChild:_pMenuAndTowerLayer];
        [self addChild:self._pWindGodLayer];
        [self addChild:self._pFireAttackLayer];
        
        
        ////////////////////////////////////////////////////////////////
        ///////     AJOUT TEMPORAIRE - bordures du HUD
        
        
        ////////////////////////////////////////////////////////////////
        
        
        // add light on tower column (particle)
        
        // Bouton God
        CCMenuItemImage *addParticleGodFireButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addGodParticle:)];
        addParticleGodFireButton.position = ccp(80, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleGodFireButton, nil];
        addMenu.position = ccp(0, 170);
        
        // ajoute le menu
        [self addChild:addMenu];
        
        // HUD Layer
        
        HUDLayer* pHUD = [HUDLayer node];
        [self addChild:pHUD];
        
        
        [self scheduleUpdate];
    }
    
    return self;
}


-(id) init
{
    [NSException raise:NSInternalInconsistencyException format:@"Please use the custom init for this class"];
    return self;
}

-(void)addGodParticle:(id)i_boutonClic
{
    
    GodData* pGodData = _pElementGodsLayer._pGodData;
    
    //Update Max : changement du dieu en cours _isAngry ici ou ailleurs? je n'ai pas trouvé ailleurs
    if (_pUpsetGodParticleLayer._pGodParticle.parent != _pUpsetGodParticleLayer)
    {
        if(pGodData._isAngry == YES)
        {
            pGodData._isAngry = FALSE;
        }
        else
        {
            pGodData._isAngry = YES;
        }
        [_pUpsetGodParticleLayer addChild:_pUpsetGodParticleLayer._pGodParticle];
        [_pElementGodsLayer playAngerAnim: nil];
        [_pMenuAndTowerLayer.pTowerLayer zoomInTower:1];

        
    }
    else if (_pUpsetGodParticleLayer._pGodParticle.parent == _pUpsetGodParticleLayer)
    {
        
        if(pGodData._isAngry == YES)
        {
            pGodData._isAngry = FALSE;
        }
        else
        {
            pGodData._isAngry = YES;
        }
        [_pElementGodsLayer playCalmDownAnim: nil];
        [_pUpsetGodParticleLayer removeChild:_pUpsetGodParticleLayer._pGodParticle cleanup:false];
        [_pMenuAndTowerLayer.pTowerLayer zoomOutTower:1];


    }
}

-(void) update:(ccTime)delta
{
    
     GameData* pCurrentGameData = super._pGameData;
     GodData* pCurrentGodData = nil;
     if(pCurrentGameData)
     pCurrentGodData = [pCurrentGameData getCurrentGod];
     
     if(pCurrentGodData)
     {
         if(pCurrentGodData._respect < GOD_ANGER_LIMIT)
         {
             
             if (_pUpsetGodParticleLayer._pGodParticle.parent != _pUpsetGodParticleLayer)
             {
                 [_pUpsetGodParticleLayer addChild:_pUpsetGodParticleLayer._pGodParticle];
             }
             // Afin de ne faire cette opération qu'une fois
             if(pCurrentGodData._isAngry == NO)
             {
                 // On lance l'animation une bonne fois pour toutes !
                 [_pElementGodsLayer playAngerAnim: nil];
                 // On met à jour la colère du dieu
                 [pCurrentGodData raiseGodAnger];
             }
             
         }
         else if(pCurrentGodData._respect >= GOD_ANGER_LIMIT && pCurrentGodData._isAngry == YES)
         {
             if (_pUpsetGodParticleLayer._pGodParticle.parent == _pUpsetGodParticleLayer)
             {
                 [_pUpsetGodParticleLayer removeChild:_pUpsetGodParticleLayer._pGodParticle cleanup:false];
             }
             
             // Comme précédemment, afin de ne le "calmer" qu'une fois
             if(pCurrentGodData._isAngry == YES)
             {
                 [_pElementGodsLayer playCalmDownAnim: nil];
                 [pCurrentGodData calmDownGodAnger];
                 [_pMenuAndTowerLayer.pTowerLayer removeBlocAtIndexes:_pMenuAndTowerLayer.pTowerLayer.indexBlocTouchByFire];
             }
         }
     }

}




@end
