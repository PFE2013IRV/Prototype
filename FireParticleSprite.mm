//
//  FireParticleSprite.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 24/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "FireParticleSprite.h"


@implementation FireParticleSprite

@synthesize _initialPosition;

-(id) init{
	if( (self=[super init]) )
    {
    
        
	}
	return self;
}

- (void) makeRandomMovement
{
    float minX = 10;
    //particle.boundingBox.size.width/2;
    float maxX = 768-minX;
    float minY = 150;
    //particle.boundingBox.size.height/2;
    float maxY = 1014;
    CGPoint target = ccp([self randFloat:minX :maxX]-_initialPosition.x, [self randFloat:minY :maxY]-_initialPosition.y);
    NSLog(@"point target: (%f,%f)", target.x, target.y);
    ccTime moveDuration = ccpDistance(self.position, target) / 100;
    
    id randomMoveAction = [CCMoveTo actionWithDuration:moveDuration position:target];
    id moveEndCallback = [CCCallFunc actionWithTarget: self selector: @selector(makeRandomMovement)];
    id sequence = [CCSequence actionOne: randomMoveAction two: moveEndCallback];
    [self runAction: sequence];
}

-(float) randFloat:(float)min :(float)max{
    float x = min + ((float)arc4random() / ARC4RANDOM_MAX) * (max - min);
    return x;
}

-(void)onEnter{
    [super onEnter];
    _initialPosition = self.position;
   // NSLog(@"position initiale:(%f,%f)", _initialPosition.x, _initialPosition.y);
   // [self makeRandomMovement];
}

@end
