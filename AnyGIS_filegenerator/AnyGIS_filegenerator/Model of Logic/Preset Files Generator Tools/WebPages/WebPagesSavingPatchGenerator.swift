//
//  WebPagesSavingPatchGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class WebPagesSavingPatchGenerator: AbstractSavingPatchGenerator {
    
    override func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, isPrivateSet: Bool, appName: ClientAppList) -> (patch: String, secondPatch: String?) {
        
        let firstPart = patchTemplates.localPathToMarkdownPages
        let secondPart = appName.rawValue.replacingOccurrences(of: " ", with: "_")
        let thirdPart = isShortSet ? "_Short" : "_Full"
        let lastPart = isEnglish ? "_en.md" : "_ru.md"
        
        //return firstPart + secondPart + thirdPart + lastPart
        return (patch: firstPart + secondPart + thirdPart + lastPart, secondPatch: nil)
    }
    
}   
