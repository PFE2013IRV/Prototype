//
//  WindAttackLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "WindAttackLayer.h"


@implementation WindAttackLayer

@synthesize _pWindParticle;

-(id) init
{
	if( (self=[super init]) )
    {
        //init particles
        _pWindParticle=[[CCParticleSystemQuad alloc] initWithFile:@"windParticle.plist"];
        // position?
        
        // Bouton add wind attack
        CCMenuItemImage *addParticleWindButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addWindParticle:)];
        addParticleWindButton.position = ccp(150, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleWindButton, nil];
        addMenu.position = ccp(0, 20);
        
        // ajoute le menu
        [self addChild:addMenu];
        
        //[self scheduleUpdate];
	}
	return self;
}

-(void)addWindParticle:(id)i_boutonClic
{
    if(_pWindParticle.parent != self)
    {
        [self addChild:_pWindParticle];
    }
    else if (_pWindParticle.parent == self)
    {
        [self removeChild:_pWindParticle cleanup:false];
    }
}

@end
