//
//  GuruSavingPatchGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class GuruSavingPatchGenerator: AbstractSavingPatchGenerator{
    
    override var shortPatch: String {
        return patchTemplates.localPathToGuruMapsShort
    }
    
    override var fullPatch: String {
        return patchTemplates.localPathToGuruMapsFull
    }
    
    override var zipPatch: String {
        return patchTemplates.localPathToGuruMapsZip
    }
    
    override func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ isPrivateSet: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {
        
        if isPrivateSet {
            let patch = generateOneMapFileSavingPatches(
                shortPatch: patchTemplates.localPathToGuruMapsPrivate,
                fullPatch: patchTemplates.localPathToGuruMapsPrivate,
                serverFolder: "",
                extention: ".ms",
                clientLine: clientLine,
                isShortSet: isShortSet,
                isEnglish: isEnglish)
            
            return (patch: patch.gitHub, secondPatch: nil)
            
        } else {
            let patches = generateOneMapFileSavingPatches(
                shortPatch: patchTemplates.localPathToGuruMapsShort,
                fullPatch: patchTemplates.localPathToGuruMapsFull,
                serverFolder: patchTemplates.localPathToGuruMapsInServer,
                extention: ".ms",
                clientLine: clientLine,
                isShortSet: isShortSet,
                isEnglish: isEnglish)
            
            return (patch: patches.gitHub, secondPatch: patches.server)
        }
    }
    
}
