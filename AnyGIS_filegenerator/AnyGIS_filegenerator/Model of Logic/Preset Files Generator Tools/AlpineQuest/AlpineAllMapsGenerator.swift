
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AlpineAllMapsGenerator: AbstractAllMapsGenerator {
    
    override var oneMapGenerator: AbstractOneMapGenerator {
        return AlpineOneMapGenerator()
    }
    
    override var patchGenerator: AbstractSavingPatchGenerator {
        return AlpineSavingPatchGenerator()
    }
    
    override var isAllMapsInOneFile: Bool {
        return false
    }
    
}
