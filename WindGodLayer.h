//
//  WindGodLayer.h
//
//  This layer contains the wind god's sprites, spritesheets, animations.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "AnimatedGodLayer.h"

@interface WindGodLayer : AnimatedGodLayer
{
    
    BOOL _godIsUp;
}

-(void) moveWindGod;

-(void) moveEnded;

@end

