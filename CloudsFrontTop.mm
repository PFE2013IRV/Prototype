//
//  CloudsTop.m
//  PFE_Prototype
//
//  Created by Karim Le Nir Aboul-Enein on 29/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "CloudsFrontTop.h"


@implementation CloudsFrontTop

@synthesize _pTopSprite;


-(id) init
{
    
    if(self=[super init])
    {
        _pTopSprite = [CCSprite spriteWithFile:@"cloudsTop_front.png"];
        
        _pTopSprite.anchorPoint = ccp(0.0f,1.0f);
        _pTopSprite.position = ccp(0.0f,1100);
        //_pTopSprite.opacity = 200;
        
        
        CCSequence* pMoveClouds = [CCSequence actions:
                                   [CCMoveBy actionWithDuration:3 position:ccp(0,-30)]
                                   ,[CCDelayTime actionWithDuration: 3.0f]
                                   ,[CCMoveBy actionWithDuration:3 position:ccp(0,30)]
                                   ,[CCDelayTime actionWithDuration: 3.0f]
                                   ,nil];
        
        CCAction* pTop= [CCRepeatForever actionWithAction:pMoveClouds];

        [self addChild:_pTopSprite];
        
        [_pTopSprite runAction:pTop];
        
    }
    
    return self;
}

@end
