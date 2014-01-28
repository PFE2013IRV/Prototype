//
//  AnimatedBackground.h
//
//  This layer contains the animated background (with an other planet and an other
//  tower being built)
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AnimatedBackground : CCNode
{
}

- (id) init;

- (id) initWithPlanetPosition: (CGPoint) i_planetPosition withScale: (float) i_scale withBeginDelay: (float) i_beginDelay;

// Runs a moveTo action on the blocs. data is an NUSSumber with the index of the sprite / action.
- (void) runMoveTo : (id) sender data: (void*) data;

// Runs a rotate action on the blocs. data is a NSArray with the the index of the sprite and the index of the rotation action.
- (void) runRotate : (id) sender data: (void*) data;

// Runs a rotate action on the blocs. data is an NUSSumber with the index of the rotation action.
- (void) runRotatePlanet : (id) sender data: (void*) data;

- (void) stopAllActions : (id) sender;

// The blocs for the animation
@property (nonatomic, strong) NSMutableArray* _aBlocs;
// The moveTo actions
@property (nonatomic, strong) NSMutableArray* _aMoveTo;
// The rotateBy actions
@property (nonatomic, strong) NSMutableArray* _aRotate;
// The planet
@property (nonatomic, strong) CCSprite* _pPlanet;

@end
