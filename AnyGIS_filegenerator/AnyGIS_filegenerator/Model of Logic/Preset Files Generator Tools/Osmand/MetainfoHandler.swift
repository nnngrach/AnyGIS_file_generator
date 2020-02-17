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
    private let patchTemplates = FilePathTemplates()
    private let osmandTemplate = OsmandMapsTemplate()
    
    
    public func create(isShortSet: Bool, filename: String, zoommin: Int64, zoommax: Int64, url: String, serverNames: String, isElipsoid: Bool, isInvertedY: Bool, isEnglish: Bool, tileSize: String, defaultTileSize: String, timeSupported: String, cachingMinutes: String) throws {
        
        let folderPatch = isShortSet ? patchTemplates.localPathToOsmandMetainfoShort : patchTemplates.localPathToOsmandMetainfoFull
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        
        let mapFolderName = folderPatch + langLabel + "=" + filename
        
        diskHandler.createFolder(patch: mapFolderName)
        
        
        let urlWithDefaultTileSize = url.replacingOccurrences(of: "{tileSize}", with: defaultTileSize)
        
        let content = osmandTemplate.getMetainfoText(url: urlWithDefaultTileSize, serverNames: serverNames, minZoom: zoommin, maxZoom: zoommax, isEllipsoid: isElipsoid, isInvertedY: isInvertedY, tileSize: tileSize, timeSupported: timeSupported, cachingMinutes: cachingMinutes)
        
        let filename = "/.metainfo"
        
        
        diskHandler.createFile(patch: mapFolderName + filename, content: content, isWithBOM: false)
        
        zipHandler.zip(sourcePath: mapFolderName,
                       archievePath: mapFolderName + ".zip")
    }
    
}
