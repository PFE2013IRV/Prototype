//
//  UpsetGodParticle.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 30/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "UpsetGodParticleLayer.h"


@implementation UpsetGodParticleLayer

@synthesize _pGodParticle;


-(id) init
{
    if( (self=[super init]) )
    {
        ///////////////////////////////////////////////////////////////////
        ///////     Initialisations des effets de particules dieux    /////
        ///////////////////////////////////////////////////////////////////
        
        // config 1
        _pGodParticle=[[CCParticleSystemQuad alloc] initWithFile:@"burningBlocParticle.plist"];
        _pGodParticle.emissionRate = 400;
        _pGodParticle.life = 1.5;
        _pGodParticle.position = ccp(90, 630);
        _pGodParticle.posVar = ccp(90, 0);
        
        // config 2
        /*_pGodParticle=[[CCParticleSystemQuad alloc] initWithFile:@"fireParticle.plist"];
        
        _pGodParticle.emissionRate = 600;
        _pGodParticle.life = 1.5;
        _pGodParticle.gravity = ccp(0, 100);
        
        _pGodParticle.position = ccp(90, 670);
        _pGodParticle.posVar = ccp(85, 0);*/
        

        
        
	}
	return self;
}

@end
