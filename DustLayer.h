//
//  DustLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DustLayer : CCNode {
    
}

@property(nonatomic, strong)CCParticleSystem* _pDustParticle;

@end