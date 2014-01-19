//
//  WindAttackLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface WindAttackLayer : CCNode {
    
}

@property(nonatomic, strong)CCParticleSystem* _pWindParticle;

-(void)addWindParticle:(id)i_boutonClic;


@end
