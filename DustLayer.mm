//
//  DustLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "DustLayer.h"


@implementation DustLayer


@synthesize _pDustParticle;

-(id) init
{
	if( (self=[super init]) )
    {
        //init particles
        _pDustParticle=[[CCParticleSystemQuad alloc] initWithFile:@"dustParticle.plist"];
        
        [self addChild:_pDustParticle];
        
        //[self scheduleUpdate];
	}
	return self;
}

@end
