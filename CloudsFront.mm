//
//  CloudsTop.m
//  PFE_Prototype
//
//  Created by Karim Le Nir Aboul-Enein on 29/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import "CloudsFront.h"


@implementation CloudsFront

@synthesize _pBottomSprite;
@synthesize _pTopSprite;


-(id) init
{
    
    if(self=[super init])
    {
        _pBottomSprite = [CCSprite spriteWithFile:@"cloudsBottom_front.png"];
        _pTopSprite = [CCSprite spriteWithFile:@"cloudsTop_front.png"];
        
        _pBottomSprite.anchorPoint = ccp(0.0f,0.0f);
        _pBottomSprite.position = ccp(0.0f,-100.0f);
        
        _pTopSprite.anchorPoint = ccp(0.0f,1.0f);
        _pTopSprite.position = ccp(0.0f,1044);
        
        
        CCSequence* pMoveClouds = [CCSequence actions:
                                   [CCMoveBy actionWithDuration:3 position:ccp(0,-20)]
                                   ,[CCDelayTime actionWithDuration: 4.0f]
                                   ,[CCMoveBy actionWithDuration:3 position:ccp(0,20)]
                                   ,[CCDelayTime actionWithDuration: 4.0f]
                                   ,nil];
        
        CCAction* pTop= [CCRepeatForever actionWithAction:pMoveClouds];
        CCAction* pBottom= [CCRepeatForever actionWithAction:pMoveClouds];

        
        [self addChild:_pBottomSprite];
        [self addChild:_pTopSprite];
        
        [_pTopSprite runAction:pTop];
        
    }
    
    return self;
}

@end
