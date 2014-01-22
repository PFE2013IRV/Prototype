//
//  ElementGodsLayer.mm
//
//  This layer contains the elementary gods' sprites, spritesheets, animations.
//

#import "ElementGodsLayer.h"

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
        
        CCAction* pActionGodFire_static1 = [CCRepeat actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_static1_Anim] times:12];
        CCAction* pActionGodFire_static2 = [CCRepeat actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_static2_Anim] times:6];
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
        
        CCSprite* pSprite_static1 = [[CCSprite spriteWithSpriteFrameName:@"static1_1.png"] autorelease];
        CCSprite* pSprite_static2 = [[CCSprite spriteWithSpriteFrameName:@"static2_1.png"] autorelease];
        CCSprite* pSprite_static3 = [[CCSprite spriteWithSpriteFrameName:@"static3_1.png"] autorelease];
        CCSprite* pSprite_colere1 = [[CCSprite spriteWithSpriteFrameName:@"colere1_1.png"] autorelease];
        
        [_aFireGodSprites setObject:pSprite_static1 forKey:@"FireGod_static1"];
        [_aFireGodSprites setObject:pSprite_static2 forKey:@"FireGod_static2"];
        [_aFireGodSprites setObject:pSprite_static3 forKey:@"FireGod_static3"];
        [_aFireGodSprites setObject:pSprite_colere1 forKey:@"FireGod_colere1"];
        
        // On lance la séquence d'actions par défaut : les animations FireGod_static
        
        [self playStaticAnims];
       
        ///////////////////////////////////////////////////////////////////
        ///////     Initialisations des effets de particules dieux    /////
        ///////////////////////////////////////////////////////////////////
        
        _pGodParticle=[[CCParticleSystemQuad alloc] initWithFile:@"godParticle.plist"];
        
        // Bouton God
        CCMenuItemImage *addParticleGodFireButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addGodParticle:)];
        addParticleGodFireButton.position = ccp(100, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleGodFireButton, nil];
        addMenu.position = ccp(0, 20);
        
        // ajoute le menu
        [self addChild:addMenu];

	}
	return self;
}

-(void) loadAnim: (id) sender data: (void*) data
{

   /* // Remise à null du sprite
    [[_aFireGodSpriteSheets objectForKey:@"FireGod_static1" ] removeAllChildrenWithCleanup:NO];
    
    NSString* sPrefix = @"FireGod_";
    NSString* sData = (NSString*) data;
    
    // Chargement de la première frame dans le sprite
    _pFireGod = [[CCSprite spriteWithSpriteFrameName:[sData stringByAppendingString:@"_1.png"]] autorelease];
    
    // Le sprite sera affilié du spritesheet
    [[_aFireGodSpriteSheets objectForKey:[sPrefix stringByAppendingString:sData]] addChild:_pFireGod];

    // Positionnement
    _pFireGod.position = ccp(110, 736);*/
}

-(void) playStaticAnims
{
    /*[_pFireGod stopAllActions];
    
    // Premier chargement pour le premier run
    [self loadAnim:nil data:@"static1"];
    
    // On définit une séquence dans laquelle on charge et on joue les animations
    // voulues les unes à la suite des autres.
    CCSequence* pSequence = [CCSequence actions:
                             [_aFireGodActions objectForKey:@"FireGod_static1"],
                             [CCCallFuncND actionWithTarget:self selector:@selector(loadAnim:data:) data:@"static2"],[_aFireGodActions objectForKey:@"FireGod_static2"],
                             [CCCallFuncND actionWithTarget:self selector:@selector(loadAnim:data:) data:@"static1"],
                             nil];
    
    // On fait en sorte qu'elle se joue pour toujours
    CCAction* pSequenceForever = [CCRepeatForever actionWithAction:pSequence];
    
    // On lance le tout !
    [_pFireGod runAction:pSequenceForever];*/
    
}

-(void)addGodParticle:(id)i_boutonClic
{
    [self addChild:_pGodParticle];
    //_isGodFireOn = true;
}

-(void)addGodParticle
{
    [self addChild:_pGodParticle];
    //_isGodFireOn = true;
}

@end
