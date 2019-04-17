//
//  GuruChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 14/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class GuruAllMapsGenerator: AbstractAllMapsGenerator {
    
    override var oneMapGenerator: AbstractOneMapGenerator {
        return GuruOneMapGenerator()
    }
    
    override var patchGenerator: AbstractSavingPatchGenerator {
        return GuruSavingPatchGenerator()
    }
    
    override var isAllMapsInOneFile: Bool {
        return false
    }
    
}



