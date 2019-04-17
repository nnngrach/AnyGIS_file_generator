//
//  LocusSavingPatchGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusSavingPatchGenerator: AbstractSavingPatchGenerator {
    
    override func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {
        
        let patches = generateOneMapFileSavingPatches(
            shortPatch: patchTemplates.localPathToLocusMapsShort,
            fullPatch: patchTemplates.localPathToLocusMapsFull,
            serverFolder: "",
            extention: ".xml",
            clientLine: clientLine,
            isShortSet: isShortSet,
            isEnglish: isEnglish)
        
        return (patch: patches.gitHub, secondPatch: nil)
    }
    
}
