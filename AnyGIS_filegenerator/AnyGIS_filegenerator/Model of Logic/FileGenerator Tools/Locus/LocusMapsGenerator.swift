//
//  LocusMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import Foundation

class LocusMapsGenerator {
    
    let diskHandler = DiskHandler()
    let baseHandler = SqliteHandler()
    let webTemplates = WebPageTemplates()
    let locusTemplates = LocusMapsTemplates()
    let patchTemplates = FilePatchTemplates()
    
    
    public func createAll(isShortSet: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData()
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forLocus else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet {continue}
            
            // Start content agregation
            var content = locusTemplates.getMapFileIntro(comment: mapClientLine.comment)
            
            content += generateLayersContent(mapClientLine.id, mapClientLine.layersIDList, mapsClientTable, mapsServerTable)
            
            content += locusTemplates.getMapFileOutro()
            
            
            // Create file
            let filename = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName + ".xml"
            
            let patch = isShortSet ? patchTemplates.localPathToLocusMapsShort : patchTemplates.localPathToLocusMapsFull
            
            let fullPatch = patch + filename
            
            diskHandler.createFile(patch: fullPatch, content: content)
        }
    }
    
    
    
    private func generateLayersContent(_ currentID: Int64, _ layersIdList: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData]) -> String {
        
        var content = ""
        
        if layersIdList == "-1" {
            
            content += addLayerBlock(locusId: currentID, background: "-1", mapsClientTable, mapsServerTable)
            
            
        } else {
            
            let layersId = layersIdList.components(separatedBy: ";")
            
            var loadId = layersId.map {Int64($0)!}
            loadId.append(currentID)
            
            var backroundId = ["-1"]
            backroundId += layersId
            
            
            for i in 0 ... layersId.count {
                
                content += addLayerBlock(locusId: loadId[i], background: backroundId[i], mapsClientTable, mapsServerTable)
            }
            
        }
        
        return content
    }
    
    
    
     private func addLayerBlock(locusId: Int64, background: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData]) -> String {
        
        let mapClientLine = mapsClientTable.filter {$0.id == locusId}.first!
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        
        // Prepare Url and server parts
        var url = ""
        var serverParts = ""
        
        if mapClientLine.locusLoadAnygis {
            url = webTemplates.anygisMapUrl
            url = url.replacingOccurrences(of: "{mapName}", with: mapServerLine.name)
            
        } else {
            url = mapServerLine.backgroundUrl
            url = url.replacingOccurrences(of: "{invY}", with: "{y}")
            
            let origServerParts = mapServerLine.backgroundServerName
            for i in origServerParts {
                serverParts.append(i)
                serverParts.append(";")
            }
            serverParts = String(serverParts.dropLast())
        }
        
        
        return locusTemplates.getMapFileItem(id: mapClientLine.id, projection: mapClientLine.projection, visible: mapClientLine.visible, background: background, group: mapClientLine.groupName, name: mapClientLine.shortName, countries: mapClientLine.countries, usage: mapClientLine.usage, url: url, serverParts: serverParts, zoomMin: mapServerLine.zoomMin, zoomMax: mapServerLine.zoomMax, referer: mapServerLine.referer)
    }
    
    
    
    private func prepareUrl(url: String, mapName: String) -> String {
        return ""
    }
    
}
