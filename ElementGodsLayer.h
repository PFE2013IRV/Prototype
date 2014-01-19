//
//  ElementGodsLayer.h
//
//  This layer contains the elementary gods' sprites, spritesheets, animations.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ElementGodsLayer : CCNode {
    
    
}

// The sprite containing the FireGod
@property (nonatomic, strong) CCSprite* _pFireGod;

// This dictionary contains all the spritesheets for the Fire God.
// The key srings are equal to the animation names.
@property (nonatomic, strong) NSMutableDictionary* _aFireGodSpriteSheets;

// This dictionary contains all the actions for the Fire God.
// The key srings are equal to the animation names.
@property (nonatomic, strong) NSMutableDictionary* _aFireGodActions;


// Flames when god is upset
@property (nonatomic, strong) CCParticleSystem* _pGodParticle;

// Add Flames with bouton (for test)
-(void)addGodParticle:(id)i_boutonClic;
// Add flames with upset...
-(void)addGodParticle;


@end
