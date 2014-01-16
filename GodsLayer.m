//
//  GodsLayer.m
//  PFE_Prototype
//
//  Created by Thibault Varacca on 10/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "GodsLayer.h"


@implementation GodsLayer

@synthesize _pFireGod;
@synthesize _pWindGod;

-(id) init
{
	if( (self=[super init]) )
    {
        _pFireGod = [CCSprite spriteWithFile:@"GodFire.png"];

        //220x280
        _pFireGod.position = ccp(110, 736);
        //  [_pWindGod initWithFile://path];
        [self addChild:_pFireGod];

        
	}
	return self;
}

@end
