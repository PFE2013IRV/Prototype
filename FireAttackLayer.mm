//
//  FireAttackLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "FireAttackLayer.h"


@implementation FireAttackLayer

@synthesize _pFireParticle1;
@synthesize _pFireParticle2;
@synthesize _pFireParticle3;
@synthesize _pFireParticle4;
@synthesize _pFireParticle5;
@synthesize _aFireParticles;
@synthesize _i;

-(id) init
{
	if( (self=[super init]) )
    {
        _i = 0;
        //init particles
        _pFireParticle1=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
        _pFireParticle1.position=ccp(20,512);
        _pFireParticle2=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
        _pFireParticle2.position=ccp(748,512);
        _pFireParticle3=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
        _pFireParticle3.position=ccp(20,158);
        _pFireParticle4=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
        _pFireParticle4.position=ccp(748,158);
        _pFireParticle5=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
        _pFireParticle5.position=ccp(190,766);
        _pFireParticle5.lifeVar=0.33;
        
        //init array
        _aFireParticles=[[NSMutableArray alloc]initWithObjects:_pFireParticle1,_pFireParticle2, _pFireParticle3, _pFireParticle4, _pFireParticle5, nil];
        
        [self addChild:[_aFireParticles objectAtIndex:0]];
        [self makeRandomMovement:[_aFireParticles objectAtIndex:0]];
        
        [self addChild:[_aFireParticles objectAtIndex:1]];
        [self makeRandomMovement:[_aFireParticles objectAtIndex:1]];
        
        [self addChild:[_aFireParticles objectAtIndex:2]];
        [self makeRandomMovement:[_aFireParticles objectAtIndex:2]];
        
//        // Bouton add fire attack
//        CCMenuItemImage *addParticleFireButton = [CCMenuItemImage itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton.png" target:self selector:@selector(addFireParticle:)];
//        addParticleFireButton.position = ccp(50, 0);
//        
//        // Menu des boutons
//        CCMenu *addMenu = [CCMenu menuWithItems:addParticleFireButton, nil];
//        addMenu.position = ccp(0, 20);
//        
//        // ajoute le menu
//        [self addChild:addMenu];
        
        //[self scheduleUpdate];
	}
	return self;
}

- (void) makeRandomMovement:(CCParticleSystem*) particle
{
    float minX = 0;
    //particle.boundingBox.size.width/2;
    float maxX = 500-minX;
    float minY = 0;
    //particle.boundingBox.size.height/2;
    float maxY = 500-minY;
    CGPoint target = ccp([self randFloat:minX :maxX], [self randFloat:minY :maxY]);
    NSLog(@"point target: (%f,%f)", target.x, target.y);
    ccTime moveDuration = 2;
    
    id randomMoveAction = [CCMoveTo actionWithDuration:moveDuration position:target];
    id moveEndCallback = [CCCallFunc actionWithTarget: self selector: @selector(makeRandomMovement:)];
    id sequence = [CCSequence actionOne: randomMoveAction two: moveEndCallback];
    [self runAction: sequence];
}

-(float) randFloat:(float)min :(float)max{
    float x = min + ((float)arc4random() / ARC4RANDOM_MAX) * (max - min);
    return x;
}

-(void)addFireParticle:(id)i_boutonClic
{
    if(_i < _aFireParticles.count){
    [self addChild:[_aFireParticles objectAtIndex:_i]];
    [self makeRandomMovement:[_aFireParticles objectAtIndex:_i]];

    _i++;
    }
    
}

@end
