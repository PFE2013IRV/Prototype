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
@property (nonatomic, assign) BOOL _isGodFireOn;


@property (nonatomic, strong) CCParticleSystemQuad* _pGodFireFront;
@property (nonatomic, strong) CCParticleSystemQuad* _pGodFireBehind;

@property (nonatomic, strong) CCParticleSystemQuad* _pLinkBlocs;

@property (nonatomic, strong) CCParticleSystemQuad* _pTowerLightColumn;

@property (nonatomic, strong) CCParticleSystem* _pGodParticle;





-(void)addFireParticle:(id)i_boutonClic;
-(void)addWindParticle:(id)i_boutonClic;
-(void)addGodParticle:(id)i_boutonClic;
-(void)godIsUpset:(id)i_boutonCLic;

@end
