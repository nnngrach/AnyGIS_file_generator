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
            
            guard mapServerLine != nil else {
                print(mapClientLine.anygisMapName, mapClientLine.id, " Server line is nil")
                continue
            }
            
            guard sasPlanetLine != nil else {
                print(mapClientLine.anygisMapName, mapClientLine.id, " Sas planet line is nil")
                continue
            }

            
            try generateMapZmp(mapClientLine, mapServerLine!, sasPlanetLine!)
        }
        
    }
    
    
    
    private func generateMapZmp(_ mapClientLine: MapsClientData, _ mapServerLine: MapsServerData, _ sasPlanetLine: SasPlanetData) throws {
        
        let folderPath = patches.localPathToSasPlanetMaps + sasPlanetLine.mapFolderPath + sasPlanetLine.mapFileName + ".zmp/"
        
        diskHandler.createFolder(patch: folderPath)
        
        
        let paramsContent = sasTemplate.getParamContent(mapClientLine, mapServerLine, sasPlanetLine)
        
        diskHandler.createFile(patch: folderPath + "params.txt", content: paramsContent)
        
    }
    
    
}
