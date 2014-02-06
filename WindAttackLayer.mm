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

@synthesize _pWindParticle1;
@synthesize _pWindParticle2;


-(id) init
{
	if( (self=[super init]) )
    {
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
    
    if(_pWindParticle1.parent != self)
    {
        //init particles
        if (self.delegate && [self.delegate respondsToSelector:@selector(DustParticlesAttackMode)])
        {
            [self.delegate DustParticlesAttackMode];
        }
        _pWindParticle1=[[CCParticleSystemQuad alloc] initWithFile:@"WindAttackParticle1.plist"];
        _pWindParticle2=[[CCParticleSystemQuad alloc] initWithFile:@"WindAttackParticle2.plist"];
        
        LevelVisitor* levelVisitor = [LevelVisitor GetLevelVisitor];
        CGPoint godPosition = levelVisitor._pCurrentGameData._pWindGodData._windGodPosition;
        _pWindParticle1.position = ccp(_pWindParticle1.position.x,godPosition.y);
        _pWindParticle2.position = ccp(_pWindParticle2.position.x,godPosition.y);
        [self addChild:_pWindParticle1];
        [self addChild:_pWindParticle2];

        
        [pScene._pWindGodLayer playCuteAnim:nil];
        [pScene._pElementGodsLayer playWindAnim:nil];

        
    }
    else if (_pWindParticle1.parent == self)
    {
        [self removeChild:_pWindParticle1 cleanup:false];
        [self removeChild:_pWindParticle2 cleanup:false];
        [pScene._pElementGodsLayer stopAllActions];
        [pScene._pElementGodsLayer playElementaryStaticAnims:nil];
        [pScene._pWindGodLayer playWindStaticAnims:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(DustParticlesNormalMode)])
        {
            [self.delegate DustParticlesNormalMode];
        }
    }
}

@end
