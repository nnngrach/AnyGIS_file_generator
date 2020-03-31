//
//  OruxSavingPatchGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OruxSavingPatchGenerator: AbstractSavingPatchGenerator {
    
    override func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, isPrivateSet: Bool, appName: ClientAppList) -> (patch: String, secondPatch: String?) {
        
        guard !isPrivateSet else {
            return (patch: patchTemplates.localPathToOruxMapsPrivate + patchTemplates.rusLanguageSubfolder + "onlinemapsources.xml",
            secondPatch: nil)
        }
        
        
        let githubPatch = isShortSet ? patchTemplates.localPathToOruxMapsShort : patchTemplates.localPathToOruxMapsFull
        
        let serverPatch = isShortSet ? patchTemplates.localPathToOruxMapsShortInServer : patchTemplates.localPathToOruxMapsFullInServer
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        
        return (patch: githubPatch + langLabel + "onlinemapsources.xml",
                secondPatch: serverPatch + langLabel + "onlinemapsources.xml")
    }
    
}
