//
//  PlanetLayer.h
//
//  The layer that contains the planet.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@protocol PlanetDelegate <NSObject>

@required
-(void)hasRotate:(int)degrees;

@optional
-(void)optionalDelegateMethodOne;
-(void)optionalDelegateMethodTwo:(NSString *)withArgument;

@end // end of delegate protocol


@interface PlanetLayer : CCLayer
{
    id <PlanetDelegate> _delegate;
}

@property (nonatomic, assign) int degreesRotation;
@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) CCSprite *pPlanetSprite;

-(id)init;
-(void)launchBalanceModeForPlanet;
-(void)stopBalanceModeForPlanet;

@end





