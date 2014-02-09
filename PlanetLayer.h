//
//  PlanetLayer.h
//
//  The layer that contains the planet.
//
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import "cocos2d.h"
#import "CloudsFrontBottom.h"


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
    CMMotionManager *motionManager;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) CCSprite *pPlanetSprite;
@property (nonatomic, assign) BOOL _isZooming;
@property (nonatomic, assign) CGPoint _positionBeforeZoom;
@property (nonatomic, assign) float _scalingFactor;
@property (nonatomic,strong) CloudsFrontBottom* _pClouds;

-(id)init;
-(void)launchBalanceModeForPlanet;
-(void)stopBalanceModeForPlanet;
-(void) removeClouds;
-(void) putCloudsAtBottom;

@end





