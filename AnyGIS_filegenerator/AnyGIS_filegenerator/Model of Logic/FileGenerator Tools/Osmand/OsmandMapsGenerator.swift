//
//  OsmandMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OsmandMapsGenerator {
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let patchTemplates = FilePatchTemplates()
    private let sqlitedbHandler = SqlitedbHandler()
    
    public func createAll(isShortSet: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData()
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forOsmand else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet {continue}
            
            let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
            
            
            try generateItem(isShortSet: isShortSet, mapClientLine, mapsServerTable)
            
        }
    }
    
    
    
    private func generateItem(isShortSet: Bool, _ mapClientLine: MapsClientData, _ mapsServerTable: [MapsServerData]) throws {
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        let filename = mapClientLine.groupPrefix + "_" + mapClientLine.clientMapName
        
        var url = mapClientLine.osmandLoadAnygis ? webTemplates.anygisMapUrl : mapServerLine.backgroundUrl
        
        url = prepareUrl(url: url, mapName: mapServerLine.name)
        
        
        var currentProjection: Int64 = 0
        
        switch mapClientLine.projection {
        case 0,1,5:
            currentProjection = 0
        case 2:
            currentProjection = 1
        default:
            fatalError("Wrong proection in OSMAND generateLayersContent()")
        }
        
        
        let minZoom = String(mapServerLine.zoomMin - 3)
        let maxZoom = String(mapServerLine.zoomMax - 3)
        
        try sqlitedbHandler.createFile(isShortSet: isShortSet,
                                       filename: filename,
                                       zoommin: minZoom,
                                       zoommax: maxZoom,
                                       patch: url,
                                       projection: currentProjection)
    }
    
    
    
    private func prepareUrl(url: String, mapName: String) -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "{1}")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "{2}")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "{0}")
        resultUrl = resultUrl.replacingOccurrences(of: "{invY}", with: "{2}")
        return resultUrl
    }
    
}
