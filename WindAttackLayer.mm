//
//  WindAttackLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "WindAttackLayer.h"
#import "ConstructionScene.h"

@implementation WindAttackLayer

@synthesize _pWindParticle;

-(id) init
{
	if( (self=[super init]) )
    {
        //init particles
        _pWindParticle=[[CCParticleSystemQuad alloc] initWithFile:@"windParticle.plist"];
        _pWindParticle.position = ccp(0, 700);
        // position?
        
        // Bouton add wind attack
        CCMenuItemImage *addParticleWindButton = [CCMenuItemImage itemWithNormalImage:@"WindButton.png" selectedImage:@"WindButton.png" target:self selector:@selector(addWindParticle:)];
        addParticleWindButton.position = ccp(130, 0);
        
        // Menu des boutons
        CCMenu *addMenu = [CCMenu menuWithItems:addParticleWindButton, nil];
        addMenu.position = ccp(0, 170);
        
        // ajoute le menu
        [self addChild:addMenu];
        
	}
	return self;
}

-(void)addWindParticle:(id)i_boutonClic
{
    ConstructionScene* pScene = (ConstructionScene*)[self parent];
    
    if(_pWindParticle.parent != self)
    {
        
        [self addChild:_pWindParticle];
        [pScene._pWindGodLayer playCuteAnim:nil];
        [pScene._pElementGodsLayer playWindAnim:nil];
        
    }
    else if (_pWindParticle.parent == self)
    {
        [self removeChild:_pWindParticle cleanup:false];
        [pScene._pElementGodsLayer stopAllActions];
        [pScene._pElementGodsLayer playElementaryStaticAnims:nil];
        [pScene._pWindGodLayer playWindStaticAnims:nil];
    }
}

@end
