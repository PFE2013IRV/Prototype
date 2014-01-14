//
//  ParticleLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 10/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class ParticleLayer;

@protocol ParticleLayerDelegate

//methodes obligatoires
//-(void)moveParticles: (CubeSprite *)cube;

@end

@interface ParticleLayer : CCLayer

// define delegate property
@property (nonatomic, assign) id  _delegate;

@property (nonatomic, assign) BOOL _isGodUpset;

//le tableau qui contient toutes les boules de feu lancées
@property (nonatomic, strong) NSMutableArray* _aFireParticles;
@property (nonatomic, strong) NSMutableArray* _aWaterParticles;
@property (nonatomic, strong) NSMutableArray* _aWindParticles;

@property (nonatomic, strong) CCParticleSystemQuad* _pGodFireFront;
@property (nonatomic, strong) CCParticleSystemQuad* _pGodFireBehind;

@property (nonatomic, strong) CCParticleSystemQuad* _pLinkBlocs;

@property (nonatomic, strong) CCParticleSystemQuad* _pTowerLightColumn;





-(void)addFireParticle:(id)i_boutonClic;
-(void)addWaterParticle:(id)i_boutonClic;

@end
