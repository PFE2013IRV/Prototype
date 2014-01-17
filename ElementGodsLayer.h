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

@end
