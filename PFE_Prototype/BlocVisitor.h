//
//  BlocVisitor.h
//  ProjectTower
//
//  The BlocVisitor is a singleton, capable to draw a bloc view from a BlocModel,
//  read the blocs in the bloc bag and write new blocs in the bloc bag.
//


#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "CCSprite.h"
#import "BlocData.h"

@interface BlocVisitor : NSObject{
    
}

// Static accessor to the single instance of the BlocVisitor
// return value : a singleton Bloc Visitor object
+(BlocVisitor*) GetBlocVisitor;

// Create a CCSprite from a BlocModel
// i_pModel : the bloc model to be converted
// return value : a CCSprite object corresponding to the bloc Data
-(CCSprite*) GetSpriteFromModel: (BlocData*) i_pData;

// Create a PNG Image from a BlocModel
// i_pModel : the bloc model to be written in a PNG file
-(void) MakePNGFromModel: (BlocData*) i_pData;

// Save a bloc
// i_pModel : the bloc model to be saved
-(void) SaveBloc: (BlocData*) i_pData;

// Load the blocs from the save file to the bloc bag
-(void) LoadBlocsToBlocBag;


@end
