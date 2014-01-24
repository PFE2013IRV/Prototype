//
//  FireAttackLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "FireParticleSprite.h"

@interface FireAttackLayer : CCNode {
    
}

-(void)addFireParticle:(id)i_boutonClic;

// gauche middle
@property(nonatomic,strong)CCParticleSystem* _pFireParticle1;
// droite middle
@property(nonatomic,strong)CCParticleSystem* _pFireParticle2;
// gauche bas
@property(nonatomic,strong)CCParticleSystem* _pFireParticle3;
// droite bas
@property(nonatomic,strong)CCParticleSystem* _pFireParticle4;
// god
@property(nonatomic,strong)CCParticleSystem* _pFireParticle5;

// tableau de particles
@property(nonatomic,strong)NSMutableArray* _aFireParticles;

@property int _i;

@end