//
//  LocusMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusMapsGenerator {
    
    private let abstract = AbstractGenerator()
    private let locusTemplates = LocusMapsTemplates()
    
    
    // TODO: Delete it
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let patchTemplates = FilePatchTemplates()
    
    
    private let replacingList = [(old: "{invY}", new: "{y}"),
                                 (old: "https", new: "http")]
    
    private let serverPartsSeparator = ";"
    
    
    public func create(isShortSet: Bool, isEnglish: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forLocus else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            if !mapClientLine.forRus && !isEnglish {continue}
            if !mapClientLine.forEng && isEnglish {continue}
            
            let mapName = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let mapCategory = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            
            // Start content agregation
            var content = locusTemplates.getMapFileIntro(comment: mapClientLine.comment)
            
            content += generateLayersContent(mapName, mapCategory, mapClientLine.id, mapClientLine.layersIDList, mapsClientTable, mapsServerTable)
            
            content += locusTemplates.getMapFileOutro()
            
            
            // Create file
            let filename = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName + ".xml"
            
            let patch = isShortSet ? patchTemplates.localPathToLocusMapsShort : patchTemplates.localPathToLocusMapsFull
            
            let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
            
            
            let fullPatch = patch + langLabel + filename
            
            diskHandler.createFile(patch: fullPatch, content: content)
        }
    }
    
    
    
    private func generateLayersContent(_ mapName: String, _ mapCategory: String, _ currentID: Int64, _ layersIdList: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData]) -> String {
        
        var content = ""
        
        if layersIdList == "-1" {
            
            //=============
            content += addLayerBlock(mapName, mapCategory, locusId: currentID, background: "-1", mapsClientTable, mapsServerTable, .Locus)
            //=============
            
            
        } else {
            
            let layersId = layersIdList.components(separatedBy: ";")
            
            var loadId = layersId.map {Int64($0)!}
            loadId.append(currentID)
            
            var backroundId = ["-1"]
            backroundId += layersId
            
            for i in 0 ... layersId.count {
                
                //=============
                content += addLayerBlock(mapName, mapCategory, locusId: loadId[i], background: backroundId[i], mapsClientTable, mapsServerTable, .Locus)
                //=============
            }
            
        }
        
        return content
    }
    
    
    
    private func addLayerBlock(_ mapName: String, _ mapCategory: String, locusId: Int64, background: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ appName: ClientAppList) -> String {
        
        let mapClientLine = mapsClientTable.filter {$0.id == locusId}.first!
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        
        var isLoadAnygis = false
        
        switch appName {
        case .Locus:
            isLoadAnygis = mapClientLine.locusLoadAnygis
        case .Osmand:
            isLoadAnygis = mapClientLine.osmandLoadAnygis
        case .Orux:
            isLoadAnygis = mapClientLine.oruxLoadAnygis
        case .GuruMapsIOS, .GuruMapsAndroid:
            isLoadAnygis = mapClientLine.gurumapsLoadAnygis
        }
        

        
        // Prepare Url and server parts
        var url = isLoadAnygis ? webTemplates.anygisMapUrl : mapServerLine.backgroundUrl
        
        url = abstract.replacrUrlParts(url: url, mapName: mapServerLine.name, parameters: replacingList)
        
        var serverParts = ""
        
        if !isLoadAnygis {
            
           let origServerParts = mapServerLine.backgroundServerName
            
            for i in origServerParts {
                serverParts.append(i)
                serverParts.append(serverPartsSeparator)
            }
            serverParts = String(serverParts.dropLast())
        }
        
        //=============
        let content = locusTemplates.getMapFileItem(id: mapClientLine.id, projection: mapClientLine.projection, visible: mapClientLine.visible, background: background, group: mapCategory, name: mapName, countries: mapClientLine.countries, usage: mapClientLine.usage, url: url, serverParts: serverParts, zoomMin: mapServerLine.zoomMin, zoomMax: mapServerLine.zoomMax, referer: mapServerLine.referer)
        //=============
        
        return content
    }
    
    

    
}
