//
//  BlocData.h
//  Blocs
//
//  This class provides a data model for the blocs
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import <vector>

@interface BlocData : NSObject
{
    std::vector<CGPoint> _aPhysicalVertices;
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
// The filename of the generated image. Unique ID.
@property (nonatomic,strong) NSString* _sFileName;
// The original bloc size, from the bloc creation
@property (nonatomic,assign) CGSize _originalSize;
// The rescaled size of the bloc
@property (nonatomic,assign) CGSize _scaledSize;



@end
