//
//  WindGodLayer.h
//
//  This layer contains the wind god's sprites, spritesheets, animations.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WindGodLayer : CCNode {
    
    BOOL _godIsUp;
}

-(void) moveWindGod;

-(void) moveEnded;

-(void) loadAnim : (NSString*) i_sAnimName;

// The sprite containing the Wind God
@property (nonatomic, strong) CCSprite* _pWindGod;

// This dictionary contains all the spritesheets for the Wind God.
// The key srings are equal to the animation names.
@property (nonatomic, strong) NSMutableDictionary* _aWindGodSpriteSheets;

// This dictionary contains all the actions for the Wind God.
// The key srings are equal to the animation names.
@property (nonatomic, strong) NSMutableDictionary* _aWindGodActions;

@end

