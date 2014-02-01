//
//  BlocManager.h
//  ProjectTower
//
//  The BlocManager is a singleton, capable to draw a bloc view from a BlocModel,
//  read the blocs in the bloc bag and write new blocs in the bloc bag.
//


#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "CCSprite.h"
#import "BlocData.h"
// Not included in "cocos2d.h"
#import "CCPhysicsSprite.h"
#import "CCRenderTexture.h"

@interface BlocManager : NSObject{
    
}

// Static accessor to the single instance of the BlocVisitor
// return value : a singleton Bloc Visitor object
+(BlocManager*) GetBlocManager;

// Create a CCSprite from a BlocModel. This method checks if there is an existing PNG
// for the BlocData. If not, it will create it.
// i_pModel : the bloc model to be converted
// return value : a CCSprite object corresponding to the bloc Data
+(CCSprite*) GetSpriteFromModel: (BlocData*) i_pData;

+(NSString*) GetNameOfPictureFromModel: (BlocData*) i_pData;

+(CCPhysicsSprite*) GetPhysicsSpriteFromModel: (BlocData*) i_pData;

// Create a PNG Image from a BlocModel
// i_pModel : the bloc model to be written in a PNG file
-(void) MakePNGMask: (BlocData*) i_pData;

- (CCSprite*) GetTexturedSprite:(CCSprite*) i_pTextureSprite maskSprite:(CCSprite*) i_pMaskSprite withBlocData:(BlocData*) i_pData;

// Save a bloc
// i_pModel : the bloc model to be saved
-(void) SaveBloc: (BlocData*) i_pData;

// Load the blocs from the save file to the bloc bag
//-(void) LoadBlocsToBlocBag;

// Delete all the bloc PNG files located in the Documents directory 
-(void) DeletePNGFiles;

// Refresh information in the bloc data when a bloc was translated with a (x,y) vector
// i_pData : the bloc model to move
// i_x : the x of the vector
// i_y : the y of the vector
-(void) MoveBlocData: (BlocData*) i_pData withX: (float) i_x withY: (float) i_y;

// Refresh information in the bloc data when a bloc is placed at the bubble point
// i_pData : the bloc model to move to the bubble point
-(void) MoveBlocDataToBubble: (BlocData*) i_pData;


@end
