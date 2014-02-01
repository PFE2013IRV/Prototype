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

// Get the std vector with the physical vertices
// retun value : the vector with the vertices treated for the physical engine.
-(std::vector<CGPoint>) GetPhysicalVertices;

// Basic init is re-implemented with NSException to be avoided
// return value : nil
-(id) init;

// The vertices array. This array can be used as in-game data and can be refrshed according to the bloc's position
@property (nonatomic,strong) NSMutableArray* _aVertices;
// The vertices array used for PNG drawing. Do not refresh during game.
@property (nonatomic,strong) NSMutableArray* _aDrawingVertices;
// The enum value of the bloc material
@property (nonatomic,assign) Material _eBlocMaterial;
// The filename of the generated image. Unique ID.
@property (nonatomic,strong) NSString* _sFileName;
// The original bloc size, from the bloc creation
@property (nonatomic,assign) CGSize _originalSize;
// The rescaled size of the bloc
@property (nonatomic,assign) CGSize _scaledSize;
// Gravity center of the scaled shape
@property (nonatomic,assign) CGPoint _gravityCenter;
// Tests if the bloc has a smaller base
@property(nonatomic,assign) BOOL _hasSmallerBase;
// The base's width
@property(nonatomic,assign) float _baseWidth;
@property(nonatomic,assign) float _specialBaseOffset;
@property(nonatomic,assign) int _indexInBlocBag;



@end
