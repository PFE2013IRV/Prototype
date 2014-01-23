//
//  GodData.h
//
//
//  Model class for an elementary god. Encapsulates his type (fire, earth, water)
//  and his level of respect.
//

#import <Foundation/Foundation.h>
#import "GlobalConfig.h"

@interface GodData : NSObject

// An init method that takes the mandatory information for a god data
// i_eGodType : the god's elementary type
// i_respect : the default value of god's respect towards the player. Can change depending on the level.
// i_isAngry : is the god angry or not ?
// i_isActive : is the god active or not ?
// retun value : self
-(id) initGod: (GodType) i_eGodType withDefaultRespect: (int)i_respect withAngerFlag: (BOOL) i_isAngry withActiveFlag: (BOOL) i_isActive;

// Basic init is re-implemented with NSException to be avoided
// return value : nil
-(id) init;


// The god's elementary type. Legal values or the values
// of the enum GodType.
@property (nonatomic,assign) GodType _eGodType;

// Tells if the god is angry or not
@property (nonatomic,assign) BOOL _isAngry;

// Tells if the god is active or not
@property (nonatomic,assign) BOOL _isActive;

// The respect integer.
@property (nonatomic,assign) int _respect;

@end
