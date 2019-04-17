//
//  MarkChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class WebPagesAllMapsGenerator: AbstractAllMapsGenerator {
    
    override var oneMapGenerator: AbstractOneMapGenerator {
        return WebPagesOneMapGenerator()
    }
    
    override var patchGenerator: AbstractSavingPatchGenerator {
        return WebPagesSavingPatchGenerator()
    }
    
    override var isAllMapsInOneFile: Bool {
        return true
    }
    
}
