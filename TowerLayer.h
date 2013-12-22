//
//  TowerLayer.h
//
//  The layer that contains the tower. It is based on a TowerData.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "TowerData.h"

@interface TowerLayer : CCLayer {
    
}

// The TowerData that contains all the layer's information
@property(nonatomic,strong) TowerData* _pTowerData;

@end
