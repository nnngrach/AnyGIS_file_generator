//
//  LocusMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusMapsGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let locusTemplates = LocusMapsTemplates()
    private let patchTemplates = FilePatchTemplates()
    
    
    public func createAll(isShortSet: Bool, isEnglish: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forLocus else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            
            // Start content agregation
            var content = locusTemplates.getMapFileIntro(comment: mapClientLine.comment)
            
            content += generateLayersContent(mapClientLine.id, mapClientLine.layersIDList, mapsClientTable, mapsServerTable, isEnglish)
            
            content += locusTemplates.getMapFileOutro()
            
            
            // Create file
            let filename = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName + ".xml"
            
            let patch = isShortSet ? patchTemplates.localPathToLocusMapsShort : patchTemplates.localPathToLocusMapsFull
            
            let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
            
            
            let fullPatch = patch + langLabel + filename
            
            diskHandler.createFile(patch: fullPatch, content: content)
        }
    }
    
    
    
    private func generateLayersContent(_ currentID: Int64, _ layersIdList: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ isEnglish: Bool) -> String {
        
        var content = ""
        
        if layersIdList == "-1" {
            
            content += addLayerBlock(locusId: currentID, background: "-1", mapsClientTable, mapsServerTable, isEnglish)
            
            
        } else {
            
            let layersId = layersIdList.components(separatedBy: ";")
            
            var loadId = layersId.map {Int64($0)!}
            loadId.append(currentID)
            
            var backroundId = ["-1"]
            backroundId += layersId
            
            
            for i in 0 ... layersId.count {
                
                content += addLayerBlock(locusId: loadId[i], background: backroundId[i], mapsClientTable, mapsServerTable, isEnglish)
            }
            
        }
        
        return content
    }
    
    
    
    private func addLayerBlock(locusId: Int64, background: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ isEnglish: Bool) -> String {
        
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
        
        let mapCategory = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
        let mapName = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
        
        
        return locusTemplates.getMapFileItem(id: mapClientLine.id, projection: mapClientLine.projection, visible: mapClientLine.visible, background: background, group: mapCategory, name: mapName, countries: mapClientLine.countries, usage: mapClientLine.usage, url: url, serverParts: serverParts, zoomMin: mapServerLine.zoomMin, zoomMax: mapServerLine.zoomMax, referer: mapServerLine.referer)
    }
    
    

    
}
