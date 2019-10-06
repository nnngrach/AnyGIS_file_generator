//
//  MetainfoHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class MetainfoHandler {
    
    private let zipHandler = ZipHandler()
    private let diskHandler = DiskHandler()
    private let patchTemplates = FilePatchTemplates()
    private let osmandTemplate = OsmandMapsTemplate()
    
    
    public func create(isShortSet: Bool, filename: String, zoommin: Int64, zoommax: Int64, url: String, isElipsoid: Bool, isEnglish: Bool, tileSize: String, defaultTileSize: String) throws {
        
        let folderPatch = isShortSet ? patchTemplates.localPathToOsmandMetainfoShort : patchTemplates.localPathToOsmandMetainfoFull
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        
        let mapFolderName = folderPatch + langLabel + filename
        
        diskHandler.createFolder(patch: mapFolderName)
        
        
        let urlWithDefaultTileSize = url.replacingOccurrences(of: "{ts}", with: defaultTileSize)
        
        
        let content = osmandTemplate.getMetainfoText(url: urlWithDefaultTileSize, minZoom: zoommin, maxZoom: zoommax, isEllipsoid: isElipsoid, tileSize: tileSize, extensiton: "")
        
        let filename = "/.metainfo"
        
        
        diskHandler.createFile(patch: mapFolderName + filename, content: content)
        
        zipHandler.zip(sourcePath: mapFolderName,
                       archievePath: mapFolderName + ".zip")
    }
    
}
