//
//  DustLayerFront.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 06/02/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "DustLayerFront.h"


@implementation DustLayerFront

@synthesize _pDustParticle1;
@synthesize _pDustParticle2;

-(id) init
{
	if( (self=[super init]) )
    {
        //init particles
        _pDustParticle1=[[CCParticleSystemQuad alloc] initWithFile:@"Dust1_particle_Front.plist"];
        _pDustParticle2=[[CCParticleSystemQuad alloc] initWithFile:@"Dust2_particle_Front.plist"];

        
        [self addChild:_pDustParticle1];
        [self addChild:_pDustParticle2];
        
        //[self scheduleUpdate];
	}
	return self;
}




@end
