//
//  DesktopAllMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 16/01/2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation


class DesktopAllMapsGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let patches = FilePathTemplates()
    private let desktopTemplate = DesktopMapsTemplate()
    
    
    public func launch(isEnglish: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            guard mapClientLine.forDesktop else {continue}
            guard mapClientLine.visible else {continue}
            
            let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
            
            
            let groupName = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            let mapName = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let fullMapName = groupName + " - " + mapName
            
            
            let content = desktopTemplate.getFileContent(mapName: fullMapName, anygisMapName: mapServerLine.name, isProxyOnly: mapClientLine.desktopLoadAnygis, url: mapServerLine.backgroundUrl, serverParts: mapServerLine.backgroundServerName, dpiSdName: mapServerLine.dpiSD, dpiHdName: mapServerLine.dpiHD, referer: mapServerLine.referer, minZoom: mapServerLine.zoomMin, maxZoom: mapServerLine.zoomMax, proection: mapClientLine.projection, anygisHostUrl: patches.serverHost)
            
            
            
            
            let folderPatch = patches.localPathToDesktopMaps
            
            let langLabel = isEnglish ? patches.engLanguageSubfolder : patches.rusLanguageSubfolder
            
            let fileName = "=" + mapClientLine.groupPrefix + "=" + mapClientLine.clientMapName
            
            let filePath = folderPatch + langLabel + fileName + ".txt"
            
            diskHandler.createFile(patch: filePath, content: content, isWithBOM: false)
        }
    }
    
}

