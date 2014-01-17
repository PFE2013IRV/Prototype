//
//  CCRotationAround.h
//  Cube
//
//  Created by Maximilien on 12/10/13.
//  Copyright (c) 2013 Alexandre Jegouic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCRotationAround : CCActionInterval <NSCopying>
{
    CGPoint center;
    float radius;
    float currentAngle;
    float startAngle;
    float delta;
    float angle;
    ccTime rotation;
    int direction;
    
}
/** creates the action */
+(id) actionWithDuration: (ccTime)duration position:(CGPoint)position radius:(float)radius direction:(int)dir rotation: (ccTime)rot angle: (float)angle;
/** initializes the action */
-(id) initWithDuration: (ccTime)duration position:(CGPoint)position radius:(float)radius direction:(int)dir rotation: (ccTime)rot angle: (float)angle;
@end