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
        
        // Bouton add fire attack
        CCMenuItemImage *addParticleFireButton = [CCMenuItemImage itemWithNormalImage:@"FireButton.png" selectedImage:@"FireButton.png" target:self selector:@selector(addFireParticle:)];
        addParticleFireButton.position = ccp(50, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleFireButton, nil];
        addMenu.position = ccp(0, 20);
        
        // ajoute le menu
        [self addChild:addMenu];

	}
	return self;
}


-(void)addFireParticle:(id)i_boutonClic
{
    if(_i < _aFireParticles.count){
        FireParticleSprite* sprite = [FireParticleSprite node];
        CCParticleSystem* particle = [_aFireParticles objectAtIndex:_i];
        sprite.position = particle.position;
        [sprite addChild:particle];
        [sprite makeRandomMovement];
        [self addChild:sprite];

    _i++;
    }
    
}

@end
