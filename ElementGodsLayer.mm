//
//  ElementGodsLayer.mm
//
//  This layer contains the elementary gods' sprites, spritesheets, animations.
//

#import "ElementGodsLayer.h"
#import "LevelVisitor.h"
#import "GodData.h"

@implementation ElementGodsLayer

@synthesize _pFireGod;
@synthesize _aFireGodActions;
@synthesize _aFireGodSpriteSheets;
@synthesize _pGodParticle;
@synthesize _aFireGodSprites;

-(id) init
{
	if( (self=[super init]) )
    {
        ///////////////////////////////////////////////////////////////////
        ///////        Création des actions pour les dieux            /////
        ///////////////////////////////////////////////////////////////////
        
        // On charge les plists relatives aux différentes spritesheets
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"FireGod_static1.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"FireGod_static2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"FireGod_static3.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"FireGod_colere1.plist"];
        
        // On charge les spritesheets en elles-mêmes et on les conserve dans un dictionnaire.
        
        _aFireGodSpriteSheets = [[NSMutableDictionary alloc] init];
        
        CCSpriteBatchNode* pFireGod_static1 = [CCSpriteBatchNode batchNodeWithFile:@"FireGod_static1.png"];
        CCSpriteBatchNode* pFireGod_static2 = [CCSpriteBatchNode batchNodeWithFile:@"FireGod_static2.png"];
        CCSpriteBatchNode* pFireGod_static3 = [CCSpriteBatchNode batchNodeWithFile:@"FireGod_static3.png"];
        CCSpriteBatchNode* pFireGod_colere1 = [CCSpriteBatchNode batchNodeWithFile:@"FireGod_colere1.png"];
        
        [_aFireGodSpriteSheets setObject:pFireGod_static1 forKey:@"FireGod_static1"];
        [_aFireGodSpriteSheets setObject:pFireGod_static2 forKey:@"FireGod_static2"];
        [_aFireGodSpriteSheets setObject:pFireGod_static3 forKey:@"FireGod_static3"];
        [_aFireGodSpriteSheets setObject:pFireGod_colere1 forKey:@"FireGod_colere1"];
        
        [self addChild:[_aFireGodSpriteSheets objectForKey:@"FireGod_static1"]];
        [self addChild:[_aFireGodSpriteSheets objectForKey:@"FireGod_static2"]];
        [self addChild:[_aFireGodSpriteSheets objectForKey:@"FireGod_static3"]];
        [self addChild:[_aFireGodSpriteSheets objectForKey:@"FireGod_colere1"]];
        
        ///////////////////////
        // Pour chaque spritesheet, on découpe en frames que l'on va conserver dans des tableaux tampons, le temps de l'initialisation.
        
        // Spritesheets à 4 frames
        NSMutableArray* aFramesFireGod_static1 = [NSMutableArray array];
        NSMutableArray* aFramesFireGod_static2 = [NSMutableArray array];
        NSMutableArray* aFramesFireGod_static3 = [NSMutableArray array];
        for (int i=1; i<=4; i++)
        {
            [aFramesFireGod_static1 addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"static1_%d.png",i]]];
            
            [aFramesFireGod_static2 addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"static2_%d.png",i]]];
            
            [aFramesFireGod_static3 addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"static3_%d.png",i]]];
        }
        
        // Spritesheets à 16 frames
        NSMutableArray* aFramesFireGod_colere1 = [NSMutableArray array];
        for (int i=1; i<=16; i++)
        {
            [aFramesFireGod_colere1 addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"colere1_%d.png",i]]];
        }
        
        // On initialise pour chaque spritesheet une animation
        
        CCAnimation* pGodFire_static1_Anim = [CCAnimation
                                              animationWithSpriteFrames:aFramesFireGod_static1 delay:0.1f];
        CCAnimation* pGodFire_static2_Anim = [CCAnimation
                                              animationWithSpriteFrames:aFramesFireGod_static2 delay:0.1f];
        CCAnimation* pGodFire_static3_Anim = [CCAnimation
                                              animationWithSpriteFrames:aFramesFireGod_static3 delay:0.1f];
        CCAnimation* pGodFire_colere1_Anim = [CCAnimation
                                              animationWithSpriteFrames:aFramesFireGod_colere1 delay:0.2f];
        
        // On initialise les différentes actions du Dieu du feu et on les conserve dans un dictionnaire
        
        _aFireGodActions = [[NSMutableDictionary alloc] init];
        
        CCAction* pActionGodFire_static1 = [CCRepeatForever actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_static1_Anim]];
        CCAction* pActionGodFire_static2 = [CCRepeatForever actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_static2_Anim]];
        CCAction* pActionGodFire_static3 = [CCRepeatForever actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_static3_Anim]];
        CCAction* pActionGodFire_colere1 = [CCRepeatForever actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_colere1_Anim]];
        
        
        [_aFireGodActions setObject:pActionGodFire_static1 forKey:@"FireGod_static1"];
        [_aFireGodActions setObject:pActionGodFire_static2 forKey:@"FireGod_static2"];
        [_aFireGodActions setObject:pActionGodFire_static3 forKey:@"FireGod_static3"];
        [_aFireGodActions setObject:pActionGodFire_colere1 forKey:@"FireGod_colere1"];
        
        
        ///////////////////////////////////////////////////////////////////
        ///////        Initialisations des sprites des dieux          /////
        ///////////////////////////////////////////////////////////////////
        
        _aFireGodSprites = [[NSMutableDictionary alloc] init];
        
        // Instance
        CCSprite* pSprite_static1 = [[CCSprite spriteWithSpriteFrameName:@"static1_1.png"] autorelease];
        CCSprite* pSprite_static2 = [[CCSprite spriteWithSpriteFrameName:@"static2_1.png"] autorelease];
        CCSprite* pSprite_static3 = [[CCSprite spriteWithSpriteFrameName:@"static3_1.png"] autorelease];
        CCSprite* pSprite_colere1 = [[CCSprite spriteWithSpriteFrameName:@"colere1_1.png"] autorelease];
        
        // Rangement
        [_aFireGodSprites setObject:pSprite_static1 forKey:@"FireGod_static1"];
        [_aFireGodSprites setObject:pSprite_static2 forKey:@"FireGod_static2"];
        [_aFireGodSprites setObject:pSprite_static3 forKey:@"FireGod_static3"];
        [_aFireGodSprites setObject:pSprite_colere1 forKey:@"FireGod_colere1"];
        
        // Filiation au spritesheet correspondant
        [[_aFireGodSpriteSheets objectForKey:@"FireGod_static1"] addChild:pSprite_static1];
        [[_aFireGodSpriteSheets objectForKey:@"FireGod_static2"] addChild:pSprite_static2];
        [[_aFireGodSpriteSheets objectForKey:@"FireGod_static3"] addChild:pSprite_static3];
        [[_aFireGodSpriteSheets objectForKey:@"FireGod_colere1"] addChild:pSprite_colere1];
        
        // Attributs par défaut
        pSprite_static1.position =
        pSprite_static2.position =
        pSprite_static3.position =
        pSprite_colere1.position = ccp(110, 733);
        
        pSprite_static1.visible =
        pSprite_static2.visible =
        pSprite_static3.visible =
        pSprite_colere1.visible = NO;
        
        // On lance la séquence d'actions par défaut : les animations FireGod_static
        
        [self playStaticAnims];
       
        ///////////////////////////////////////////////////////////////////
        ///////     Initialisations des effets de particules dieux    /////
        ///////////////////////////////////////////////////////////////////
        
        _pGodParticle=[[CCParticleSystemQuad alloc] initWithFile:@"godParticle.plist"];
        
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

- (void) refreshGodInfo
{
    // On regarde à quel dieu on à faire et remet à jour la variable de colère
    GameData* pCurrGameData = [LevelVisitor GetLevelVisitor]._pCurrentGameData;
    GodData* pGodData = [pCurrGameData getCurrentGod];
    
    _isAngry = pGodData._isAngry;
    _eCurrentGod = pGodData._eGodType;
}

- (void) playStaticAnims
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    [self refreshGodInfo];
    
    CCSequence* pSequence = nil;
    
    if(_isAngry == NO)
    {
        // On met en place une séquence d'animations alternant static1 et static2
        pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static1"],
         [CCDelayTime actionWithDuration: 3.2f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static1"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static2"],
         [CCDelayTime actionWithDuration: 2.4f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"static2"],
         nil];
    }
    else if(_isAngry == YES)
    {
        // On met en place une séquence d'animations
        pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static3"],
         nil];        
    }
    
    // La séquence se joue "pour toujours"
    //... ou du moins jusqu'à ce qu'on l'arrête nous mêmes !
    CCAction* pSequenceForever = [CCRepeatForever actionWithAction:pSequence];
    
    [self runAction:pSequenceForever];
}

-(void) playAngerAnim
{
    // On stoppe toutes les séquences d'actions précédentes
    [self stopAllRuningAnimations];
    
    // On refraichit l'information sur le dieu courant
    // au cas où celle-ci ait changé
    [self refreshGodInfo];
    
    CCSequence* pSequence =
        [CCSequence actions:
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"colere1"],
         [CCDelayTime actionWithDuration: 3.2f],
         [CCCallFuncND actionWithTarget:self selector:@selector(stopAnim:data:) data:@"colere1"],
         [CCCallFuncND actionWithTarget:self selector:@selector(runAnim:data:) data:@"static3"],
         nil];
    
    [self runAction:pSequence];
}

- (void) runAnim: (id) sender data: (void*) data
{
    // On récupère le type de dieu pour lequel il faut lancer l'animation
    NSString* sGodType;
    
    if(_eCurrentGod == GOD_TYPE_FIRE)
        sGodType = @"FireGod_";
    else if(_eCurrentGod == GOD_TYPE_WATER)
        sGodType = @"WaterGod_";
    else if(_eCurrentGod == GOD_TYPE_EARTH)
        sGodType = @"EarthGod_";
    
    NSString* sAnimName = [sGodType stringByAppendingString:(NSString*) data];
    CCSprite* pAnimSprite = (CCSprite*) [_aFireGodSprites objectForKey:sAnimName];
    
    [pAnimSprite stopAllActions];
    [pAnimSprite setVisible:YES];
    
    [pAnimSprite runAction:[_aFireGodActions objectForKey:sAnimName]];
}

- (void) stopAnim: (id) sender data: (void*) data
{
    // On récupère le type de dieu pour lequel il faut stopper l'animation
    NSString* sGodType;
    
    if(_eCurrentGod == GOD_TYPE_FIRE)
        sGodType = @"FireGod_";
    else if(_eCurrentGod == GOD_TYPE_WATER)
        sGodType = @"WaterGod_";
    else if(_eCurrentGod == GOD_TYPE_EARTH)
        sGodType = @"EarthGod_";
    
    NSString* sAnimName = [sGodType stringByAppendingString:(NSString*) data];
    CCSprite* pAnimSprite = (CCSprite*) [_aFireGodSprites objectForKey:sAnimName];
    
    [pAnimSprite stopAllActions];
    [pAnimSprite setVisible:NO];
}

- (void) stopAllRuningAnimations
{
    // On arrête toutes les actions sur les sprites du Dieu concerné.
    NSMutableDictionary* aCurrentDico;
    
    //if(_eCurrentGod == GOD_TYPE_FIRE)
        aCurrentDico = [NSMutableDictionary dictionaryWithDictionary:_aFireGodSprites];
    /*else if(_eCurrentGod == GOD_TYPE_WATER)
        aCurrentDico = _aWaterGodSprites;
    else if(_eCurrentGod == GOD_TYPE_EARTH)
        aCurrentDico = _aEarthGodSprites;*/
    
    for(id sKey in aCurrentDico)
    {
        CCSprite* pSprite = [aCurrentDico objectForKey:sKey];
        [pSprite stopAllActions];
        [pSprite setVisible:NO];
    }
    
    // On arrête toutes les séquences en cours sur le layer.
    [self stopAllActions];
}

-(void)addGodParticle:(id)i_boutonClic
{
    if (_pGodParticle.parent != self) {
        [self addChild:_pGodParticle];
        [self playAngerAnim];
    }
    else if (_pGodParticle.parent == self){
        [self playStaticAnims];
        [self removeChild:_pGodParticle cleanup:false];
    }
}

-(void)addGodParticle
{
    if (_pGodParticle.parent != self) {
        [self addChild:_pGodParticle];
        [self playAngerAnim];
    }
    else if (_pGodParticle.parent == self){
        [self playStaticAnims];
        [self removeChild:_pGodParticle cleanup:false];
    }
}

@end
