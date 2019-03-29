//
//  GuruMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 28/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import Foundation

class GuruMapsGenerator {
    
    let diskHandler = DiskHandler()
    let baseHandler = SqliteHandler()
    let webTemplates = WebPageTemplates()
    let guruTemplates = GuruTemplates()
    let patchTemplates = FilePatchTemplates()
    
    
    
    public func createAll(isShortSet: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData()
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forGuru else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet {continue}
            
            
            // Start content agregation
            var content = guruTemplates.getFileIntro(mapName: mapClientLine.shortName, comment: mapClientLine.comment)
            
            content += generateLayersContent(mapClientLine.id, mapClientLine.layersIDList, mapsClientTable, mapsServerTable)
            
            content += guruTemplates.getFileOutro()
            
            
            // Create file
            let filename = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName + ".ms"
            
            let patch = isShortSet ? patchTemplates.localPathToGuruMapsShort : self.patchTemplates.localPathToGuruMapsFull
            
            let fullPatch = patch + filename
            
            diskHandler.createFile(patch: fullPatch, content: content)
            
            
            // Copy dublicate file to Public folder to use with Downloader script
            if !isShortSet {
                
                let serverPatch = patchTemplates.localPathToGuruMapsInServer + filename
                
                self.diskHandler.createFile(patch: serverPatch, content: content)
            }
        }
    }
    
    
    
    
     private func generateLayersContent(_ currentID: Int64, _ layersIdList: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData]) -> String {
        
        var content = ""
        
        if layersIdList == "-1" {
            
            content += addLayerBlock(locusId: currentID, mapsClientTable, mapsServerTable)
            
        } else {
            
            let layersId = layersIdList.components(separatedBy: ";")
            
            var loadId = layersId.map {Int64($0)!}
            
            loadId.append(currentID)
            
            for i in 0 ... layersId.count {
                
                content += addLayerBlock(locusId: loadId[i], mapsClientTable, mapsServerTable)
                
            }
        }
        
        return content
    }
    
    
    
    
    
    private func addLayerBlock(locusId: Int64, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData]) -> String {
        
        let mapClientLine = mapsClientTable.filter {$0.id == locusId}.first!
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        // Prepare Url and server parts
        var url = mapClientLine.gurumapsLoadAnygis ? webTemplates.anygisMapUrl : mapServerLine.backgroundUrl
        
        url = prepareUrl(url: url, mapName: mapServerLine.name)
        
        
        var serverParts = ""
        
        if !mapClientLine.gurumapsLoadAnygis {
            
            for i in mapServerLine.backgroundServerName {
                
                serverParts.append(i)
                
                serverParts.append(" ")
            }
        }
        
        return guruTemplates.getItem(url: url, zoomMin: mapServerLine.zoomMin, zoomMax: mapServerLine.zoomMax, serverParts: serverParts)
    }
    
    
    
    
    private func prepareUrl(url: String, mapName: String) -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "{$x}")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "{$y}")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "{$z}")
        resultUrl = resultUrl.replacingOccurrences(of: "{s}", with: "{$serverpart}")
        resultUrl = resultUrl.replacingOccurrences(of: "{invY}", with: "{$invY}")
        resultUrl = resultUrl.replacingOccurrences(of: "&", with: "&amp;")
        return resultUrl
    }
    
}
