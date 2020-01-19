//
//  SasPnanetAllMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/10/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class SasPnanetAllMapsGenerator {
    
    private let zipHandler = ZipHandler()
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let sasTemplate = SasPlanetTemplate()
    private let patches = FilePatchTemplates()

    
    
    public func launch() throws {
        
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: false)
        
        for mapClientLine in mapsClientTable {
            
            guard mapClientLine.forSas else {continue}
            guard mapClientLine.visible else {continue}
            
            let mapServerLine = try baseHandler.getMapsServerDataBy(name: mapClientLine.anygisMapName)
            let sasPlanetLine = try baseHandler.getSasPlanetDataBy(name: mapClientLine.anygisMapName)
            let mapPreviewLine = try baseHandler.getMapsPreviewBy(name: mapClientLine.anygisMapName)
            
            guard mapServerLine != nil else {
                print(mapClientLine.anygisMapName, mapClientLine.id, " Server line is nil")
                continue
            }
            
            guard sasPlanetLine != nil else {
                print(mapClientLine.anygisMapName, mapClientLine.id, " Sas planet line is nil")
                continue
            }
            
            guard mapPreviewLine != nil else {
                print(mapClientLine.anygisMapName, mapClientLine.id, " Preview line is nil")
                continue
            }

            
            try generateMapZmp(mapClientLine, mapServerLine!, sasPlanetLine!, mapPreviewLine!)
        }
        
    }
    
    
    
    private func generateMapZmp(_ mapClientLine: MapsClientData, _ mapServerLine: MapsServerData, _ sasPlanetLine: SasPlanetData, _ mapPreviewLine: MapsPreviewData) throws {
        
        let folderPath = patches.localPathToSasPlanetFolder + "Maps/" + sasPlanetLine.mapFolderPath + sasPlanetLine.mapFileName + ".zmp/"
        
        diskHandler.createFolder(patch: folderPath)
        
        
        let paramsContent = sasTemplate.getParamContent(mapClientLine, mapServerLine, sasPlanetLine, mapPreviewLine)
        
        diskHandler.createFile(patch: folderPath + "params.txt", content: paramsContent, isUtf8: false)
        
        
        
        let textTemplatesFolderPatch = patches.localPathToSasPlanetFolder + "Templates/"
        
        diskHandler.secureCopyItem(at: textTemplatesFolderPatch + "GetUrlScript.txt", to: folderPath + "GetUrlScript.txt")
        diskHandler.secureCopyItem(at: textTemplatesFolderPatch + "info.txt", to: folderPath + "info.txt")
        
        
        let iconFolderPatch = patches.localPathToSasPlanetFolder + "Icons/" + sasPlanetLine.icon + "/"
                
        diskHandler.secureCopyItem(at: iconFolderPatch + "18.bmp", to: folderPath + "18.bmp")
        diskHandler.secureCopyItem(at: iconFolderPatch + "24.bmp", to: folderPath + "24.bmp")
    }
    
    
}
