//
//  BlocData.h
//  Blocs
//
//  This class provides a data model for the blocs
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"

@interface BlocData : NSObject{
    
}

// An init method that takes the mandatory information for a bloc data
// i_aVertices : a static array with the blocs vertices. The coordinates are absolute (coordinates of the stars)
// i_eBlocMaterial : an enum with the material
// retun value : self
-(id) initBloc : (NSArray*)i_aVertices withMaterial: (Material)i_eBlocMaterial;

// Basic init is re-implemented with NSException to be avoided
// return value : nil
-(id) init;

// The vertices array
@property (nonatomic,strong) NSMutableArray* _aVertices;
// The enum value of the bloc material
@property (nonatomic,assign) Material _eBlocMaterial;
// The filename of the generated image
@property (nonatomic,strong) NSString* _sFileName;


@end
