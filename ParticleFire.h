//
//  ParticleFire.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 04/02/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ParticleFire : CCParticleSystemQuad {
    
}

@property (nonatomic, assign) CGPoint _target;
@property (nonatomic, assign) CGPoint _initialPosition;
@property(nonatomic, assign) float _pente;
@property(nonatomic, assign) float _coeffB;


@end
