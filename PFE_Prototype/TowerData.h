//
//  TowerData.h
//  ProjectTower
//
//  This class provides a data model for the tower
//

#import <Foundation/Foundation.h>


@interface TowerData : NSObject


// Basic init is re-implemented
-(id) init;

// The blocs array. This array is represents the tower from the bottom to the top bloc
@property (nonatomic,strong) NSMutableArray* _aBlocs;

@end

