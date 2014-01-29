//
//  ConstructionScene.m
//
//  The construction game scene
//

#import "ConstructionScene.h"
#import "CloudsBack.h"
#import "CloudsFront.h"


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
        
        // CIEL ET BACKGROUND
        CGPoint positionBkg1 = ccp(580,700);
        CGPoint positionBkg2 = ccp(160,340);
        
        AnimatedBackground* pBkg1 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg1 withScale:0.5 withBeginDelay:20 withPlanetType:1];
        AnimatedBackground* pBkg2 = [[AnimatedBackground alloc] initWithPlanetPosition:positionBkg2 withScale:1 withBeginDelay:10 withPlanetType:2];
        CloudsBack* pCloudsBack = [[CloudsBack alloc] init];
        CloudsFront* pCloudsFront = [[CloudsFront alloc] init];
        
        [self addChild:self._pSkyLayer];
        [self addChild:self._pStarsLayer];
        [self._pSunLayer ManageSunConstruction];
        [self addChild:self._pDustLayer];
        [self addChild:pBkg1];
        [self addChild:pBkg2];
        
        [self addChild:self._pWindGodLayer];
        [self addChild:self._pSunLayer];
        [self addChild:pCloudsBack];
        [self addChild:self._pPlanetLayer];
        [self addChild:pCloudsFront];
        [self addChild:self._pGodWrathLayer];
        [self addChild:self._pElementGodsLayer];
        
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
        
        // Bouton God
        CCMenuItemImage *addParticleGodFireButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addGodParticle:)];
        addParticleGodFireButton.position = ccp(80, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleGodFireButton, nil];
        addMenu.position = ccp(0, 170);
        
        // ajoute le menu
        [self addChild:addMenu];
        
        
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
    if (_pElementGodsLayer._pGodParticle.parent != _pElementGodsLayer)
    {
        if(pGodData._isAngry == YES)
        {
            pGodData._isAngry = FALSE;
        }
        else
        {
            pGodData._isAngry = YES;
        }
        [_pElementGodsLayer addChild:_pElementGodsLayer._pGodParticle];
        [_pElementGodsLayer playAngerAnim: nil];
        [super._pWindGodLayer playCuteAnim:nil];
        
    }
    else if (_pElementGodsLayer._pGodParticle.parent == _pElementGodsLayer)
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
        [super._pWindGodLayer playWindStaticAnims:nil];
        [_pElementGodsLayer removeChild:_pElementGodsLayer._pGodParticle cleanup:false];
    }
}


@end
