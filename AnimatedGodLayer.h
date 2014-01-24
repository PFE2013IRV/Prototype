//
//  AnimatedGodLayer.h
//
//
//  Base class for all the animated gods (fire, water, earth and wind)
//  Defines all the base behaviors for animations and animations cycles.
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "cocos2d.h"

@interface AnimatedGodLayer : CCLayer
{
    // The god type is saved here
    GodType _eGodType;
}

// An init method that takes the mandatory information for an animated god
// i_eGodType : the god type. God types are defined in GlobalConfig.
// i_aAnimStrings : An array with the names of the animations.
// retun value : self
- (id) initWithGod: (GodType) i_eGodType withAnims: (NSArray*) i_aAnimStrings;

// This is a callback function that will run the animation
// corresponding to the given data. This callback shall be called by
// sequences in specialized classes (elementary god or wind god animation sequences)
// sender : the event sender
// data : the key for the animation. Must be passed as a string.
- (void) runAnim: (id) sender data: (void*) data;

// This is a callback function that will stop the animation
// corresponding to the given data. This callback shall be called by
// sequences in specialized classes (elementary god or wind god animation sequences)
// sender : the event sender
// data : the key for the animation. Must be passed as a string.
- (void) stopAnim: (id)sender data: (void *)data;

// This function stops all the animations on the animated god.
- (void) stopAllRuningAnimations;

// The sprite containing the god sprites
@property (nonatomic, strong) NSMutableDictionary* _aGodSprites;

// This dictionary contains all the spritesheets for the current god.
// The key srings are equal to the animation names.
@property (nonatomic, strong) NSMutableDictionary* _aGodSpriteSheets;

// This dictionary contains all the actions for the current god.
// The key srings are equal to the animation names.
@property (nonatomic, strong) NSMutableDictionary* _aGodActions;

@end
