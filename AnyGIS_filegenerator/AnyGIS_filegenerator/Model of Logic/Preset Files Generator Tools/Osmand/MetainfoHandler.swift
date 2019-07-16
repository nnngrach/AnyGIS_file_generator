//
//  MetainfoHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class MetainfoHandler {
    
    private let diskHandler = DiskHandler()
    private let patchTemplates = FilePatchTemplates()
    private let osmandTemplate = OsmandMapsTemplate()
    
    
    public func create(isShortSet: Bool, filename: String, zoommin: Int64, zoommax: Int64, url: String, isElipsoid: Bool, isEnglish: Bool, tileSize: String) throws {
        
        let folderPatch = isShortSet ? patchTemplates.localPathToOsmandMetainfoMapsShort : patchTemplates.localPathToOsmandMetainfoMapsFull
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        
        let mapFolderName = folderPatch + langLabel + filename
        
        diskHandler.createFolder(patch: mapFolderName)
        
        
        
        let content = osmandTemplate.getMetainfoText(url: url, minZoom: zoommin, maxZoom: zoommax, isEllipsoid: isElipsoid, tileSize: tileSize, extensiton: "")
        
        let filename = "/.metainfo"
        
        
        diskHandler.createFile(patch: mapFolderName + filename, content: content)
    }
    
}
