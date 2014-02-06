//
//  WindAttackLayer.h
//  PFE_Prototype
//
//  Created by Thibault Varacca on 19/01/2014.
//  Copyright 2014 Karim Le Nir Aboul-Enein. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol WindAttackDelegate <NSObject>

@required

-(void)DustParticlesAttackMode;
-(void)DustParticlesNormalMode;

@end // end of delegate protocol

@interface WindAttackLayer : CCLayer {
    id <WindAttackDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;

@property(nonatomic, strong)CCParticleSystem* _pWindParticle1;
@property(nonatomic, strong)CCParticleSystem* _pWindParticle2;

-(void)addWindParticle:(id)i_boutonClic;


@end
