//
//  BlocBagData.h
//
//  The BlocBagData contains the data related to the bloc bag (content, max size, etc...)
//  It's a singleton object.
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"
#import "BlocData.h"

@interface BlocBagData : NSObject

// Static accessor to the single instance of the BlocBagData.
// return value : a singleton object with the BlocBagData
+(BlocBagData*) GetBlocBagData;

// Static accessor to the single instance of the BlocBagData.
// i_eBagSize : the bag size. Legal values are the values of the BagSize enum.
// i_aBlocs : an array of BlocData. Its size must be less than i_eBagSize !
-(void) SetBlocBagData : (BagSize) i_eBagSize withBlocs: (NSMutableArray*) i_aBlocs;

// The bloc data array
@property (nonatomic,strong) NSMutableArray* _aBlocs;
// The maximum size of the bag (game unlock)
// The legal values are the values of the BagSize enum
@property (nonatomic,assign) BagSize _eBagSize;


@end

