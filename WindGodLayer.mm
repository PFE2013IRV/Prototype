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
        
        CCAction* pActionGodFire_moveUp = [CCRepeat actionWithAction:
                                            [CCAnimate actionWithAnimation:pGodFire_moveUp_Anim] times:1];
        
        
        [_aWindGodActions setObject:pActionGodFire_moveUp forKey:@"WindGod_moveUp"];
        
        
        ///////////////////////////////////////////////////////////////////
        ///////        Initialisations des sprites des dieux          /////
        ///////////////////////////////////////////////////////////////////
        
        // On lance l'action par défaut : WindGod_static1
        
        
        _godIsUp = NO;
        [self moveWindGod];
        
	}
    
	return self;
}

-(void) loadAnim : (NSString*) i_sAnimName
{
    _pWindGod = nil;
    NSString* sPrefix = @"WindGod_";
    
    _pWindGod = [[CCSprite spriteWithSpriteFrameName:[i_sAnimName stringByAppendingString:@"_1.png"]] autorelease];
    [[_aWindGodSpriteSheets objectForKey:[sPrefix stringByAppendingString:i_sAnimName]] addChild:_pWindGod];
    
    [_pWindGod setScale:0.8];
    _pWindGod.anchorPoint = ccp(0.0f,0.0f);
}

-(void) moveWindGod
{
    CGPoint goalPosition;
    NSString* sAnimName, *sWindGod = @"WindGod_";

    if(_godIsUp == YES)
    {
        sAnimName = @"moveDown";
        [self loadAnim:sAnimName];
        _pWindGod.position = ccp(590, 600);
        goalPosition = ccp(590, 232);
        _godIsUp = NO;
    }
    else
    {
        sAnimName = @"moveUp";
        [self loadAnim:sAnimName];
        goalPosition = ccp(590, 600);
        _pWindGod.position = ccp(590, 232);
        _godIsUp = YES;
    }
    
    CCAction* pMoveAction = [CCMoveTo actionWithDuration:1.5 position:goalPosition];
    
    [_pWindGod stopAllActions];
    [_pWindGod runAction:[_aWindGodActions objectForKey:[sWindGod stringByAppendingString:sAnimName]]];
    [_pWindGod runAction:pMoveAction];
}


@end

