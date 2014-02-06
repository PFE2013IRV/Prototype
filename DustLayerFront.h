//
//  DustLayerFront.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 06/02/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "WindAttackLayer.h"
#import "LevelVisitor.h"
#import "GodData.h"
#import "GameData.h"

@interface DustLayerFront : CCLayer{
    
}

@property(nonatomic, strong)CCParticleSystem* _pDustParticle1;
@property(nonatomic, strong)CCParticleSystem* _pDustParticle2;

@end
