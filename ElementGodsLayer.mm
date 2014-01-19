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
        
        // On lance l'action par défaut : FireGod_static1
        _pFireGod = [CCSprite spriteWithSpriteFrameName:@"static1_1.png"];
        
        [[_aFireGodSpriteSheets objectForKey:@"FireGod_static1"] addChild:_pFireGod];
        [_pFireGod runAction:[_aFireGodActions objectForKey:@"FireGod_static1"]];
        
        // Positionnement par défaut
        _pFireGod.position = ccp(110, 736);
       
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
