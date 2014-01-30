//
//  FireAttackLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define ARC4RANDOM_MAX 0x100000000

@interface FireAttackLayer : CCNode {
    
}

-(void)addFireParticle:(id)i_boutonClic;
-(void)initParticles;
-(float) randFloat:(float)min :(float)max;
-(void)moveParticle:(CCParticleSystem*)particle withIndex:(int)index ;

// gauche bas
@property(nonatomic,strong)CCParticleSystem* _pFireParticle1;
// gauche middle
@property(nonatomic,strong)CCParticleSystem* _pFireParticle2;
// gauche haut
@property(nonatomic,strong)CCParticleSystem* _pFireParticle3;
// droite bas
@property(nonatomic,strong)CCParticleSystem* _pFireParticle4;
// droite middle
@property(nonatomic,strong)CCParticleSystem* _pFireParticle5;
// droite haut
@property(nonatomic,strong)CCParticleSystem* _pFireParticle6;

// tableau de particles
@property(nonatomic,strong)NSMutableArray* _aFireParticles;


@end
