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

-(id) init
{
	if( (self=[super init]) )
    {
        ///////////////////////////////////////////////////////////////////
        ///////        Création des actions pour les dieux            /////
        ///////////////////////////////////////////////////////////////////
        
        // On charge les plists relatives aux différentes spritesheets
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"FireGod_static1.plist"];
        
        // On charge les spritesheets en elles-mêmes et on les conserve dans un dictionnaire.
        
        _aFireGodSpriteSheets = [[NSMutableDictionary alloc] init];
        
        CCSpriteBatchNode* pFireGod_static1 = [CCSpriteBatchNode batchNodeWithFile:@"FireGod_static1.png"];
        
        [_aFireGodSpriteSheets setObject:pFireGod_static1 forKey:@"FireGod_static1"];
        
        [self addChild:[_aFireGodSpriteSheets objectForKey:@"FireGod_static1"]];
        
        // Pour chaque spritesheet, on découpe en frames que l'on va conserver dans des tableaux tampons, le temps de l'initialisation.
        
        NSMutableArray* aFramesFireGod_static1 = [NSMutableArray array];
        for (int i=1; i<=4; i++)
        {
            [aFramesFireGod_static1 addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"%d.png",i]]];
        }
        
        // On initialise pour chaque spritesheet une animation
        
        CCAnimation* pGodFire_static1_Anim = [CCAnimation
                                              animationWithSpriteFrames:aFramesFireGod_static1 delay:0.1f];
        
        // On initialise les différentes actions du Dieu du feu et on les conserve dans un dictionnaire
        
        _aFireGodActions = [[NSMutableDictionary alloc] init];
        
        CCAction* pActionGodFire_static1 = [CCRepeatForever actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_static1_Anim]];
        
        
        [_aFireGodActions setObject:pActionGodFire_static1 forKey:@"FireGod_static1"];
        
        
        ///////////////////////////////////////////////////////////////////
        ///////        Initialisations des sprites des dieux          /////
        ///////////////////////////////////////////////////////////////////
        
        // On lance l'action par défaut : FireGod_static1
        _pFireGod = [CCSprite spriteWithSpriteFrameName:@"1.png"];
        
        [[_aFireGodSpriteSheets objectForKey:@"FireGod_static1"] addChild:_pFireGod];
        [_pFireGod runAction:[_aFireGodActions objectForKey:@"FireGod_static1"]];
        
        // Positionnement par défaut
        _pFireGod.position = ccp(110, 736);
        
	}
	return self;
}

@end
