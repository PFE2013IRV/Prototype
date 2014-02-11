//
//  ConstructionScene.m
//
//  The construction game scene
//

#import "ConstructionScene.h"
#import "BlocManager.h"
#import "GlobalConfig.h"
#import "BalanceScene.h"
#import "SimpleAudioEngine.h"

@implementation ConstructionScene

@synthesize _pElementGodsLayer;
@synthesize _pFireAttackLayer;
@synthesize _pUpsetGodParticleLayer;
@synthesize _pMenuAndTowerLayer;
@synthesize _pGodWrathLayer;
@synthesize _pBkg1;
@synthesize _pBkg2;
@synthesize _pWindAttackLayer;
@synthesize _pWindGodLayer;
@synthesize _pHUD;


-(void) changeScene
{
    [self._pElementGodsLayer requestBigCleanUp];
    [self._pWindGodLayer requestBigCleanUp];
    
    [CDAudioManager sharedManager].backgroundMusic.volume = VOLUME_BALANCE;
    
    CCSprite* currentBackground = self._pSkyLayer._pBackground;
    ccColor3B color3 = self._pSunLayer._pSoleil.color;
    ccColor4B currentSunColor = ccc4(color3.r, color3.g, color3.b, 255);
    
    TowerData *tower  = [LevelVisitor GetLevelVisitor]._pCurrentGameData._pTowerData;
    [self changeSceneFromConstructionToBalanceWithId: nil TowerData:tower CurrentBackground:currentBackground CurrentSunColor:currentSunColor];
    
}

-(id) initGameScene : (GameData*) i_pGameData
{
    if(!i_pGameData)
    {
        NSLog(@"Fatal error : constructions scene init failed");
    }
    else if (self = [super init])
    {
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"MusiqueTower.m4a"];
        [CDAudioManager sharedManager].backgroundMusic.volume = VOLUME_CONSTRUCTION;
        
        _pWindAttackLayer = [WindAttackLayer node];
        _pWindGodLayer = [WindGodLayer node];
        _pElementGodsLayer = [ElementGodsLayer node];
        _pFireAttackLayer = [FireAttackLayer node];
        _pUpsetGodParticleLayer = [UpsetGodParticleLayer node];
        _pGodWrathLayer = [GodWrathLayer node];
        _pMenuAndTowerLayer = [[[MenuAndConstructionTowerLayer alloc] initWithTowerData:i_pGameData._pTowerData HeightWin:i_pGameData.winHeight] autorelease];
        
        self._pGameData = i_pGameData;
        
        [self._pSkyLayer ManageBackgroundConstruction];
        
        // CIEL ET BACKGROUND

        
        _pFireAttackLayer.delegate = _pMenuAndTowerLayer.pTowerLayer;
        self._pWindAttackLayer.delegate = self;
        
        [self addChild:self._pSkyLayer];
        
        if(!SIMULATOR_MODE)
            [self addChild:self._pStarsLayer];
        
        [self._pSunLayer ManageSunConstruction];
        
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
            CloudsFrontTop* pCloudsFront = [[CloudsFrontTop alloc] init];
            [self addChild:pCloudsFront];
        }
        
        
        [self addChild:self._pGodWrathLayer];
        [self addChild:self._pUpsetGodParticleLayer];
        [self addChild:self._pDustLayerBack];
        
        [self addChild:self._pWindGodLayer];
        [self addChild:self._pDustLayerFront];
        
        

        [self addChild:self._pFireAttackLayer];
        
        [self addChild:_pMenuAndTowerLayer];
        
        _pHUD = [HUDLayer node];
        [self addChild:_pHUD];
        
        
        [self addChild:self._pElementGodsLayer];
        
        
        [self addChild:self._pWindAttackLayer];



        
        CloudsFrontTop* pCloudsFront = [[CloudsFrontTop alloc] init];
        [self addChild:pCloudsFront];

        
        //CCSprite* AnniversaireHugo = [CCSprite spriteWithFile:@"AnniversaireHugo.png"];
        
        
        // add light on tower column (particle)
        
        // Bouton God
        /*CCMenuItemImage *addParticleGodFireButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addGodParticle:)];
        addParticleGodFireButton.position = ccp(80, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleGodFireButton, nil];
        addMenu.position = ccp(0, 170);
        
        // ajoute le menu
        [self addChild:addMenu];*/
        
        
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

-(void) changeSceneFromConstructionToBalanceWithId : (int) _iLevelId TowerData : (TowerData*) _iTowerData CurrentBackground : (CCSprite*) i_CurrentBackground CurrentSunColor : (ccColor4B) i_CurrentSunColor
{
    
    BalanceScene* balanceScene = [[[BalanceScene alloc] initGameScene:[[LevelVisitor GetLevelVisitor ]StartLevelBalanceWithId:_iLevelId TowerData:_iTowerData] CurrentBackground:i_CurrentBackground //CurrentSun:i_CurrentSunColor
                                   ] autorelease];
    //balanceScene.TowerSize = Tower
    balanceScene.previusScene = self;
    
    [[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:1.0 scene:balanceScene]];
                                               }
                                               
-(void) update:(ccTime)delta
{
    _runtime += delta;
    
    GameData* pCurrentGameData = super._pGameData;
    GodData* pCurrentGodData = nil;
    WindGodData* pWindGodData = nil;
    
    if(pCurrentGameData)
    {
        pCurrentGodData = [pCurrentGameData getCurrentGod];
        pWindGodData = pCurrentGameData._pWindGodData;
    }
    
     if(pCurrentGodData && pWindGodData)
     {
         
         // On lance l'attaque du dieu du vent si le dieu du vent ne bouge pas et qu'on a atteint la limite de temps fixée pour le prototype
         if(_runtime > WIND_GOD_ATTACK_TIME && pWindGodData._godIsMoving == NO)
         {
             pWindGodData._godIsAttacking = YES;
             [self LaunchWindGodAttack : pCurrentGodData];
         }
         
         // Les attaques des dieux élémentaires ne sont lancées que lorsque le dieu du vent n'est pas en train d'attaquer
         if(pWindGodData._godIsAttacking == NO)
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
                     // On change la hauteur de scroll autorisée et on place la tour en haut (afin que le joueur ne puisse pas éviter les boules de feu)
                     
                     
                     // On lance l'animation une bonne fois pour toutes !
                     [_pElementGodsLayer playAngerAnim: nil];
                     [_pFireAttackLayer addFireParticle];
                     [_pMenuAndTowerLayer godIsAngry];
                     // On met à jour la colère du dieu
                     [pCurrentGodData raiseGodAnger];
                     
                     
                 }
                 if (_pFireAttackLayer.canLaunchOtherFireBalls)
                 {
                     [_pFireAttackLayer addFireParticle];
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
                     [_pFireAttackLayer endFireBalls];
                     [_pMenuAndTowerLayer godBecameNotAngry];
                     [_pMenuAndTowerLayer.pTowerLayer removeBlocAtIndexes:_pMenuAndTowerLayer.pTowerLayer.indexBlocTouchByFire];
                     
                 }
             }
         }
     }

}

-(void) LaunchWindGodAttack : (GodData*) i_pCurrentGod
{
    [self unscheduleUpdate];
    
    CCSequence* pWindGodAttackSequence = nil;
    
    // On calme d'abord le dieu
    id calmDownGod = [CCCallBlock actionWithBlock:^
    {
        GodData* pCurrentGod = [super._pGameData getCurrentGod];
        
        if(pCurrentGod._isAngry == YES)
        {
            if (_pUpsetGodParticleLayer._pGodParticle.parent == _pUpsetGodParticleLayer)
            {
                [_pUpsetGodParticleLayer removeChild:_pUpsetGodParticleLayer._pGodParticle cleanup:true];
            }
            
            [_pElementGodsLayer playCalmDownAnim: nil];
            [pCurrentGod calmDownGodAnger];
            [_pFireAttackLayer endFireBalls];
            [_pMenuAndTowerLayer godBecameNotAngry];
            [_pMenuAndTowerLayer.pTowerLayer removeBlocAtIndexes:_pMenuAndTowerLayer.pTowerLayer.indexBlocTouchByFire];
        }
        
    }];
    
    // On retire le menu de l'écran
    id moveMenuOutOfScreen = [CCCallBlock actionWithBlock:^
    {
        CCAction* pMoveMenu = [CCMoveBy actionWithDuration:2.0 position:ccp(0,-150)];
        [_pMenuAndTowerLayer.pMenuLayer runAction:pMoveMenu];
        
        CCAction* pMoveSunTimer = [CCMoveBy actionWithDuration:2.0 position:ccp(0,-20)];
        [_pHUD._pHUDSunTimer runAction:pMoveSunTimer];
        
        CCAction* pMoveTimerFrame = [CCMoveBy actionWithDuration:2.0 position:ccp(0,-20)];
        [_pHUD._pHUDSunFrame runAction:pMoveTimerFrame];
        
        
        CCAction* pMoveRespect = [CCMoveBy actionWithDuration:2.0 position:ccp(-200,0)];
        [_pHUD._pHUDRespect runAction:pMoveRespect];

    }];
    
    // On dézoom sur la tour
    id zoomOutonTower = [CCCallBlock actionWithBlock:^
    {
        [_pMenuAndTowerLayer.pTowerLayer zoomOutTower:1];
    }];
    
    // Mise en rogne du dieu du vent
    id windGodisAngry = [CCCallBlock actionWithBlock:^
    {
        [_pWindGodLayer playWindGodAttackSequence:nil];
    }];
    
    id lauchnWindAttack = [CCCallBlock actionWithBlock:^
    {
        [_pWindAttackLayer addWindParticle:nil];
    }];

    
    
    
    
    
    pWindGodAttackSequence = [CCSequence actions:calmDownGod,
                              windGodisAngry,
                              moveMenuOutOfScreen,
                              [CCDelayTime actionWithDuration:1.5],
                              zoomOutonTower,
                              [CCDelayTime actionWithDuration:2.0],
                              lauchnWindAttack,
                              nil];
    
    [self runAction:pWindGodAttackSequence];
    
}


-(void)DustParticlesAttackMode{
    
    LevelVisitor* levelVisitor = [LevelVisitor GetLevelVisitor];
    CGPoint godPosition = levelVisitor._pCurrentGameData._pWindGodData._windGodPosition;
    self._pDustLayerBack._pDustParticle1.position = ccp(768, godPosition.y);
    self._pDustLayerBack._pDustParticle1.posVar = ccp(0, 60);
    self._pDustLayerBack._pDustParticle1.gravity = ccp(0, 0);
    
    self._pDustLayerBack._pDustParticle2.position = ccp(768, godPosition.y);
    self._pDustLayerBack._pDustParticle2.posVar = ccp(0, 60);
    self._pDustLayerBack._pDustParticle2.gravity = ccp(0, 0);
    
    self._pDustLayerFront._pDustParticle1.position = ccp(768, godPosition.y);
    self._pDustLayerFront._pDustParticle1.posVar = ccp(0, 60);
    self._pDustLayerFront._pDustParticle1.gravity = ccp(0, 0);
    
    self._pDustLayerFront._pDustParticle2.position = ccp(768, godPosition.y);
    self._pDustLayerFront._pDustParticle2.posVar = ccp(0, 60);
    self._pDustLayerFront._pDustParticle2.gravity = ccp(0, 0);
}

-(void)DustParticlesNormalMode{
    self._pDustLayerBack._pDustParticle1.position = ccp(768, 580);
    self._pDustLayerBack._pDustParticle1.posVar = ccp(0, 494);
    self._pDustLayerBack._pDustParticle1.gravity = ccp(0, -10);
    
    self._pDustLayerBack._pDustParticle2.position = ccp(768, 580);
    self._pDustLayerBack._pDustParticle2.posVar = ccp(0, 494);
    self._pDustLayerBack._pDustParticle2.gravity = ccp(0, -10);
    
    self._pDustLayerFront._pDustParticle1.position = ccp(768, 580);
    self._pDustLayerFront._pDustParticle1.posVar = ccp(0, 60);
    self._pDustLayerFront._pDustParticle1.gravity = ccp(0, -10);
    
    self._pDustLayerFront._pDustParticle2.position = ccp(768, 580);
    self._pDustLayerFront._pDustParticle2.posVar = ccp(0, 494);
    self._pDustLayerFront._pDustParticle2.gravity = ccp(0, -10);
}




@end
