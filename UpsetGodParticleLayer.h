//
//  UpsetGodParticleLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 30/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface UpsetGodParticleLayer : CCLayer {
    
}

// Flames when god is upset
@property (nonatomic, strong) CCParticleSystem* _pGodParticle;

@end
