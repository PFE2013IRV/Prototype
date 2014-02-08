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
        
        _pGodParticle=[[CCParticleSystemQuad alloc] initWithFile:@"burningBlocParticle.plist"];
        _pGodParticle.position = ccp(126, 596);
        _pGodParticle.posVar = ccp(100, 0);
        

        
        
	}
	return self;
}

@end
