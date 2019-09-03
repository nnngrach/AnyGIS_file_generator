//
//  OruxSavingPatchGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OruxSavingPatchGenerator: AbstractSavingPatchGenerator {
    
    override func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) -> (patch: String, secondPatch: String?) {
        
        let githubPatch = isShortSet ? patchTemplates.localPathToOruxMapsShort : patchTemplates.localPathToOruxMapsFull
        
        let serverPatch = isShortSet ? patchTemplates.localPathToOruxMapsShortInServer : patchTemplates.localPathToOruxMapsFullInServer
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        //return patch + langLabel + "onlinemapsources.xml"
        
        print()
        
        return (patch: githubPatch + langLabel + "onlinemapsources.xml",
                secondPatch: serverPatch + langLabel + "onlinemapsources.xml")
    }
    
}
