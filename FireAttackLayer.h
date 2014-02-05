//
//  FireAttackLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ParticleFire.h"

#define ARC4RANDOM_MAX 0x100000000

@protocol FireAttackDelegate <NSObject>

@required

-(void)handleParticle:(ParticleFire*) particle;
-(void)getParticles:(NSMutableArray*) particles;
-(void)setParticles:(NSMutableArray*) particles;

@end // end of delegate protocol

@interface FireAttackLayer : CCLayer {
    id <FireAttackDelegate> _delegate;
    
}

-(void)addFireParticle:(id)i_boutonClic;
-(void)initParticles;
-(float) randFloat:(float)min :(float)max;

@property (nonatomic, strong) id delegate;

// gauche bas
@property(nonatomic,strong)ParticleFire* _pFireParticle1;
// gauche middle
@property(nonatomic,strong)ParticleFire* _pFireParticle2;
// gauche haut
@property(nonatomic,strong)ParticleFire* _pFireParticle3;
// droite bas
@property(nonatomic,strong)ParticleFire* _pFireParticle4;
// droite middle
@property(nonatomic,strong)ParticleFire* _pFireParticle5;
// droite haut
@property(nonatomic,strong)ParticleFire* _pFireParticle6;


// tableau de particles
@property(nonatomic,strong)NSMutableArray* _aFireParticles;

@property(nonatomic, assign)ccTime _duration;

@property(nonatomic, assign)int _speed;


@end
