//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AlpineSavingPatchGenerator: AbstractSavingPatchGenerator {
    
    override var shortPatch: String {
        return patchTemplates.localPathToAlpineMapsShort
    }
    
    override var fullPatch: String {
        return patchTemplates.localPathToAlpineMapsFull
    }
    
    override var zipPatch: String {
        return patchTemplates.localPathToAlpineMapsZip
    }
    
    
    override func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ isPrivateSet: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {
        
        let patches = generateOneMapFileSavingPatches(
            shortPatch: patchTemplates.localPathToAlpineMapsShort,
            fullPatch: patchTemplates.localPathToAlpineMapsFull,
            serverFolder: patchTemplates.localPathToAlpineMapsInServer,
            extention: ".AQX",
            clientLine: clientLine,
            isShortSet: isShortSet,
            isEnglish: isEnglish)
        
        return (patch: patches.gitHub, secondPatch: patches.server)
    }
    
}
