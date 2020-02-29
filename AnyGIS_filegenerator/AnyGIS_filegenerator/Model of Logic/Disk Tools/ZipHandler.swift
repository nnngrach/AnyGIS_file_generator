//
//  ZipHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 19/08/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation
import ZIPFoundation

class ZipHandler {
    
    public func zip(sourcePath: String, archievePath: String) {
        
        let sourceURL = URL(string: sourcePath)!
        let archieveURL = URL(string: archievePath)!
        let fileManager = FileManager()
        
        do {
            try fileManager.zipItem(at: sourceURL, to: archieveURL)
        } catch {
            print("Creation of ZIP archive failed with error:\(error)")
        }
    }
    
    
    
    
    public func zipMapsFolder(sourceShort: String, SouceFull: String, zipPath: String, isShortSet: Bool, isEnglish: Bool, isForFolders: Bool) {
        
            let sourcePatch = isShortSet ? sourceShort : SouceFull
            let firstPart = isShortSet ? "Maps_short" : "Maps_full"
            let secondPart = isEnglish ? "_en" : "_ru"
            let forFoldersPart = isForFolders ? "_folders" : ""
            
            let fullSoucePath = sourcePatch + forFoldersPart + secondPart
            let fullArchievePath = zipPath + firstPart + forFoldersPart + secondPart + ".zip"
            
            zip(sourcePath: fullSoucePath, archievePath: fullArchievePath)
    }
    
    
    
    

    
}
