//
//  LocusSavingPatchGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusSavingPatchGenerator: AbstractSavingPatchGenerator {
    
    override var shortPatch: String {
        return patchTemplates.localPathToLocusMapsShort
    }
    
    override var fullPatch: String {
        return patchTemplates.localPathToLocusMapsFull
    }
    
    override var zipPatch: String {
        return patchTemplates.localPathToLocusMapsZip
    }
    
    override func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ isPrivateSet: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {
        
        if isPrivateSet {
            let patch = generateOneMapFileSavingPatches(
                shortPatch: patchTemplates.localPathToLocusMapsPrivate,
                fullPatch: patchTemplates.localPathToLocusMapsPrivate,
                serverFolder: "",
                extention: ".xml",
                clientLine: clientLine,
                isShortSet: isShortSet,
                isEnglish: isEnglish)
            
            return (patch: patch.gitHub, secondPatch: nil)
            
        } else {
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
    
}
