//
//  ConstructionScene.m
//
//  The construction game scene
//

#import "ConstructionScene.h"
#import "BlocManager.h"
#import "GlobalConfig.h"

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
        [super._pWindGodLayer playCuteAnim:nil];
        [_pMenuAndTowerLayer.pTowerLayer zoomInTower:1];

        
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        CCSprite* baseBloc = [_pMenuAndTowerLayer.pTowerLayer._aBlocsTowerSprite firstObject];
        float planetZoomYPosition = 100;//;baseBloc.position.y + (screenSize.height - SCROLLING_HEIGHT - 20);
        
        //[_pMenuAndTowerLayer.pPlanetLayer zoomInPlanet:_pMenuAndTowerLayer.pTowerLayer.scalingFactor withEndYPosition:planetZoomYPosition];

        
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
        [super._pWindGodLayer moveWindGod:nil];
        [_pUpsetGodParticleLayer removeChild:_pUpsetGodParticleLayer._pGodParticle cleanup:false];
        [_pMenuAndTowerLayer.pTowerLayer zoomOutTower:1];
        //[_pMenuAndTowerLayer.pPlanetLayer zoomOutPlanet:1];

    }
}


@end
