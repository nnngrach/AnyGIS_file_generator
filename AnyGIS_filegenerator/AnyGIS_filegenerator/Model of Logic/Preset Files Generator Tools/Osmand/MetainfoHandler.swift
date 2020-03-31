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
    
    
    
    public func create(dto: OsmandGeneratorDTO) throws {
        
        var folderPatch = ""
        
        if dto.isPrivateSet {
            folderPatch = patchTemplates.localPathToOsmandMetainfoPrivate
        } else {
            if dto.isShortSet {
                folderPatch = patchTemplates.localPathToOsmandMetainfoShort
            } else {
                folderPatch = patchTemplates.localPathToOsmandMetainfoFull
            }
        }
        
        
        let langLabel = dto.isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        
        let mapFolderName = folderPatch + langLabel + "=" + dto.filename
        
        diskHandler.createFolder(patch: mapFolderName)
        
        
        let urlWithDefaultTileSize = dto.url.replacingOccurrences(of: "{tileSize}", with: dto.defaultTileSize)
        
        let content = osmandTemplate.getMetainfoText(url: urlWithDefaultTileSize, serverNames: dto.serverNames, minZoom: dto.zoommin, maxZoom: dto.zoommax, isEllipsoid: dto.isEllipsoid, isInvertedY: dto.isInvertedY, tileSize: dto.tileSize, timeSupported: dto.timeSupport, cachingMinutes: dto.cachingMinutes)
        
        let filename = "/.metainfo"
        
        
        diskHandler.createFile(patch: mapFolderName + filename, content: content, isWithBOM: false)
        
        zipHandler.zip(sourcePath: mapFolderName,
                       archievePath: mapFolderName + ".zip")
    }
    
    
}
