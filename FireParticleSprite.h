//
//  FireParticleSprite.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 24/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define ARC4RANDOM_MAX 0x100000000


@interface FireParticleSprite : CCSprite {

    
}

- (void) makeRandomMovement;

// Returns a random float in [min, max)
-(float) randFloat:(float)min :(float)max;

@property  CGPoint _initialPosition;

@end
