//
//  SasPnanetAllMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/10/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class SasPlanetMapsGenerator {
    
    private let diskHandler = DiskHandler()
    private let dbHandler = SqliteHandler()
    private let filePathes = FilePathTemplates()
    private let textTemplate = SasPlanetTemplate()
    

    // Start iterating in db
    public func launch(isSavingInGitFolder: Bool) throws {
        
        let mapsClientTable = try dbHandler.getMapsClientData(isEnglish: false)
        
        
        for mapClientLine in mapsClientTable {
            
            // Skip non SasPlanet records
            guard mapClientLine.visible else {continue}
            guard mapClientLine.forSas else {continue}
            
            // Load data from binded tables
            let mapServerLine = try dbHandler.getMapsServerDataBy(name: mapClientLine.anygisMapName)
            let sasPlanetLine = try dbHandler.getSasPlanetDataBy(name: mapClientLine.anygisMapName)
            let mapPreviewLine = try dbHandler.getMapsPreviewBy(name: mapClientLine.anygisMapName)
            
            // Error Handling
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
            
            
            // Start generating script
            try generateMapZmp(isSavingInGitFolder, mapClientLine, mapServerLine!, sasPlanetLine!, mapPreviewLine!)
        }
        
    }
    
    
    
    
    // Generating script
    private func generateMapZmp(_ isInGitFolder: Bool, _ mapClientLine: MapsClientData, _ mapServerLine: MapsServerData, _ sasPlanetLine: SasPlanetData, _ mapPreviewLine: MapsPreviewData) throws {
        
        // Create .ZMP folder
        let rootFolder = isInGitFolder ? filePathes.localPathToSasPlanetInGitFolder : filePathes.localPathToSasPlanetMaps
        
        let folderPath = rootFolder + sasPlanetLine.mapFileName + ".zmp/"
        
        diskHandler.createFolder(patch: folderPath)
        
        
        // Generate Params.txt in Utf8 DOM format
        let paramsContent = textTemplate.getParamsTxtContent(mapClientLine, mapServerLine, sasPlanetLine, mapPreviewLine)
        
        diskHandler.createFile(patch: folderPath + "params.txt", content: paramsContent, isWithBOM: true)
        
        
        // Copy unchanging txt files
        //diskHandler.secureCopyItem(at: filePathes.localPathToSasPlanetTemplates + "GetUrlScript.txt", to: folderPath + "GetUrlScript.txt")
        diskHandler.secureCopyItem(at: filePathes.localPathToSasPlanetTemplates + "info.txt", to: folderPath + "info.txt")
        
        
        // Copy one of standatd icon files
        let iconFolderPatch = filePathes.localPathToSasPlanetIcons + sasPlanetLine.icon + "/"
                
        diskHandler.secureCopyItem(at: iconFolderPatch + "18.bmp", to: folderPath + "18.bmp")
        diskHandler.secureCopyItem(at: iconFolderPatch + "24.bmp", to: folderPath + "24.bmp")
    }
    
}
