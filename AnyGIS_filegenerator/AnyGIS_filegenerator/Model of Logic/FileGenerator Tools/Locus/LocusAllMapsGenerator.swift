//
//  LocusChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 14/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusAllMapsGenerator: AbstractAllMapsGenerator {
        
    override var oneMapGenerator: AbstractOneMapGenerator {
        return LocusOneMapGenerator()
    }
    
    override var patchGenerator: AbstractSavingPatchGenerator {
        return LocusSavingPatchGenerator()
    }
    
    override var isAllMapsInOneFile: Bool {
        return false
    }
    
}
