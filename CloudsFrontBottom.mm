//
//  CloudsTop.m
//  PFE_Prototype
//
//  Created by Karim Le Nir Aboul-Enein on 29/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "CloudsFrontBottom.h"


@implementation CloudsFrontBottom

@synthesize _pBottomSprite;


-(id) init
{
    
    if(self=[super init])
    {
        _pBottomSprite = [CCSprite spriteWithFile:@"cloudsBottom_front.png"];
        _pBottomSprite.anchorPoint = ccp(0.0f,0.0f);
        _pBottomSprite.position = ccp(0.0f,-50.0f);

        
        CCSequence* pMoveClouds = [CCSequence actions:
                                   [CCMoveBy actionWithDuration:3 position:ccp(0,-30)]
                                   ,[CCDelayTime actionWithDuration: 3.0f]
                                   ,[CCMoveBy actionWithDuration:3 position:ccp(0,30)]
                                   ,[CCDelayTime actionWithDuration: 3.0f]
                                   ,nil];
        
        CCAction* pBottom= [CCRepeatForever actionWithAction:pMoveClouds];

        
        [self addChild:_pBottomSprite];
        
        [_pBottomSprite runAction:pBottom];
        
    }
    
    return self;
}

@end
