//
//  OruxChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OruxAllMapsGenerator: AbstractAllMapsGenerator {
    
    override var oneMapGenerator: AbstractOneMapGenerator {
        return OruxOneMapGenerator()
    }
    
    override var patchGenerator: AbstractSavingPatchGenerator {
        return OruxSavingPatchGenerator()
    }
    
    override var isAllMapsInOneFile: Bool {
        return true
    }
    
}
