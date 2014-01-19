//
//  WindGodLayer.mm
//
//  This layer contains the wind god's sprites, spritesheets, animations.
//

#import "WindGodLayer.h"



@implementation WindGodLayer

@synthesize _pWindGod;
@synthesize _aWindGodActions;
@synthesize _aWindGodSpriteSheets;

-(id) init
{
	if( (self=[super init]) )
    {
        ///////////////////////////////////////////////////////////////////
        ///////        Création des actions pour les dieux            /////
        ///////////////////////////////////////////////////////////////////
        
        // On charge les plists relatives aux différentes spritesheets
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"WindGod_moveUp.plist"];
        
        // On charge les spritesheets en elles-mêmes et on les conserve dans un dictionnaire.
        
        _aWindGodSpriteSheets = [[NSMutableDictionary alloc] init];
        
        CCSpriteBatchNode* pWindGod_moveUp = [CCSpriteBatchNode batchNodeWithFile:@"WindGod_moveUp.png"];
        
        [_aWindGodSpriteSheets setObject:pWindGod_moveUp forKey:@"WindGod_moveUp"];
        
        [self addChild:[_aWindGodSpriteSheets objectForKey:@"WindGod_moveUp"]];
        
        ///////////////////////
        // Pour chaque spritesheet, on découpe en frames que l'on va conserver dans des tableaux tampons, le temps de l'initialisation.
        
        // Spritesheets à 13 frames
        NSMutableArray* aFramesWindGod_moveUp = [NSMutableArray array];
        for (int i=1; i<=13; i++)
        {
            [aFramesWindGod_moveUp addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"moveUp_%d.png",i]]];
        }
        
        // On initialise pour chaque spritesheet une animation
        
        CCAnimation* pGodFire_moveUp_Anim = [CCAnimation
                                              animationWithSpriteFrames:aFramesWindGod_moveUp delay:0.2f];
        
        // On initialise les différentes actions du Dieu du feu et on les conserve dans un dictionnaire
        
        _aWindGodActions = [[NSMutableDictionary alloc] init];
        
        CCAction* pActionGodFire_moveUp = [CCRepeatForever actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_moveUp_Anim]];
        
        
        [_aWindGodActions setObject:pActionGodFire_moveUp forKey:@"WindGod_moveUp"];
        
        
        ///////////////////////////////////////////////////////////////////
        ///////        Initialisations des sprites des dieux          /////
        ///////////////////////////////////////////////////////////////////
        
        // On lance l'action par défaut : WindGod_static1
        _pWindGod = [CCSprite spriteWithSpriteFrameName:@"moveUp_1.png"];
        
        [[_aWindGodSpriteSheets objectForKey:@"WindGod_moveUp"] addChild:_pWindGod];
        [_pWindGod runAction:[_aWindGodActions objectForKey:@"WindGod_moveUp"]];
        
        // Positionnement par défaut
        _pWindGod.position = ccp(400, 300);
        
	}
	return self;
}

@end

