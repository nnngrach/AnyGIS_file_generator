//
//  GuruMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 28/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OruxMapsGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let oruxTemplates = OruxTemplates()
    private let patchTemplates = FilePatchTemplates()
    

    
    public func createAll(isShortSet: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData()
        
        // Start content agregation
        var content = oruxTemplates.getFileIntro()
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forOrux else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet {continue}
            
            content += generateBlock(mapClientLine.id, mapClientLine.layersIDList, mapsClientTable, mapsServerTable)
        }
        
        content += oruxTemplates.getFileOutro()
        
        
        // Create file
        let patch = isShortSet ? patchTemplates.localPathToOruxMapsShortInServer : patchTemplates.localPathToOruxMapsFullInServer
        
        let fullPatch = patch + "onlinemapsources.xml"
        
        diskHandler.createFile(patch: fullPatch, content: content)
    }
    
    
    
    
    private func generateBlock(_ currentID: Int64, _ layersIdList: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData]) -> String {
        
        let mapClientLine = mapsClientTable.filter {$0.id == currentID}.first!
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        // Prepare Url and server parts
        var url = mapClientLine.oruxLoadAnygis ? webTemplates.anygisMapUrl : mapServerLine.backgroundUrl
        
        url = prepareUrl(url: url, mapName: mapServerLine.name)
        
        
        // Start content agregation
        var serverParts = ""
        
        let origServerParts = mapServerLine.backgroundServerName
        for i in origServerParts {
            serverParts.append(i)
            serverParts.append(",")
        }
        serverParts = String(serverParts.dropLast())
        
        
        var yInvertingScript = ""
        var currentProjection = ""
        
        switch mapClientLine.projection {
        case 0, 5:
            currentProjection = "MERCATORESFERICA"
        case 1:
            currentProjection = "MERCATORESFERICA"
            yInvertingScript = "0"
        case 2:
            currentProjection = "MERCATORELIPSOIDAL"
        default:
            fatalError("Wrong proection in ORUX generateLayersContent()")
        }
        
        let cacheable = mapClientLine.cacheStoringHours == 0 ? 0 : 1
        
        
        return oruxTemplates.getItem(id: mapClientLine.id, projectionName: currentProjection, name: mapClientLine.shortName, group: mapClientLine.oruxGroupPrefix, url: url, serverParts: serverParts, zoomMin: mapServerLine.zoomMin, zoomMax: mapServerLine.zoomMax, cacheable: cacheable, yInvertingScript: yInvertingScript)
    }
    
    
    
    
    private func prepareUrl(url: String, mapName: String) -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "{$x}")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "{$y}")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "{$z}")
        resultUrl = resultUrl.replacingOccurrences(of: "{s}", with: "{$s}")
        resultUrl = resultUrl.replacingOccurrences(of: "{invY}", with: "{$y}")
        resultUrl = resultUrl.replacingOccurrences(of: "{$quad}", with: "{$q}")
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        return resultUrl
    }
    
}
