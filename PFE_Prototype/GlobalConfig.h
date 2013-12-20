//
//  GlobalConfig.h
//  ProjectTower
//
//  Created by Karim Le Nir Aboul-Enein on 18/12/2013.
//  Copyright (c) 2013 Karim Le Nir Aboul-Enein. All rights reserved.
//

#ifndef ProjectTower_GlobalConfig_h
#define ProjectTower_GlobalConfig_h

// The savepath for the PNG export of the bloc is statically defined here
static const char* CGF_TMP_PNG_SAVEPATH = "";

// The savepath for the bloc bag data
static const char* CFG_BLOCBAG_SAVEPATH = "";

// Materials are defined here in this enum
enum Material {
    MAT_NULL = 0,
    MAT_WOOD = 1,
    MAT_GLASS = 2
};
typedef enum Material Material;

// Possible bloc bag sizes are defined n this enum
enum BagSize {
    BAG_SIZE_NULL = 0,
    BAG_SIZE_SMALL = 5,
    BAG_SIZE_MEDIUM = 10,
    BAG_SIZE_BIG = 20,
    BAG_SIZE_GOD_LIKE = 50
};
typedef enum BagSize BagSize;


#endif
