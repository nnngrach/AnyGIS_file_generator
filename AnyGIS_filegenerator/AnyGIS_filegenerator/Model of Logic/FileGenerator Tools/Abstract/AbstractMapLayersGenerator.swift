//
//  AbstractFunctions.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 16/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AbstractMapLayersGenerator {
    
    public let webTemplates = WebPageTemplates()
    
    
    public var serverNamesSeparator: String {
        return ";"
    }
    
    public var urlPartsForReplacement: [(old: String, new: String)] {
        return []
    }
    
    
    
    public func getAllLayersContent(_ mapName: String, _ mapCategory: String, _ currentID: Int64, _ layersIdList: String, _ mapsClientLine: MapsClientData, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ isEnglish: Bool, _ appName: ClientAppList, _ previousCategory: String) -> String {
        
        
        var content = ""
        
        
        if layersIdList == "-1" {
            
            content += getOneLayerContent(mapName, mapCategory, locusId: currentID, background: "-1", mapsClientTable, mapsServerTable, isEnglish, appName, previousCategory)
            
        } else {
            
            let layersId = layersIdList.components(separatedBy: ";")
            
            var loadId = layersId.map {Int64($0)!}
            loadId.append(currentID)
            
            var backroundId = ["-1"]
            backroundId += layersId
            
            for i in 0 ... layersId.count {
                
                content += getOneLayerContent(mapName, mapCategory, locusId: loadId[i], background: backroundId[i], mapsClientTable, mapsServerTable, isEnglish, appName, previousCategory)
            }
        }
        
        return content
    }
    
    
    
    
    
    private func getOneLayerContent(_ mapName: String, _ mapCategory: String, locusId: Int64, background: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ isEnglish: Bool, _ appName: ClientAppList, _ previousCategory: String) -> String {
        
        
        var content = ""
        
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
        
        url = replaceUrlParts(url: url, mapName: mapServerLine.name, parameters: urlPartsForReplacement)
        
        
        var serverPartsInClientFormat = ""
        
        if !isLoadAnygis {
            
            let storedServerParts = mapServerLine.backgroundServerName
            
            for i in storedServerParts {
                serverPartsInClientFormat.append(i)
                serverPartsInClientFormat.append(serverNamesSeparator)
            }
            serverPartsInClientFormat = String(serverPartsInClientFormat.dropLast())
        }
        
        
        let tileSize = mapClientLine.isRetina ? "512" : "256"
        
        
        content += generateOneLayerContent(mapName, mapCategory, url, serverPartsInClientFormat, background, tileSize, isEnglish, appName, mapClientLine, mapServerLine)
        
        return content
    }
    
    
    
    
    
    public func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ tileSize: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        return ""
    }
    
    
    
    
    
    private func replaceUrlParts(url: String, mapName: String, parameters: [(old: String,new: String)]) -> String {
        
        var resultUrl = url
        
        for pameter in parameters {
            resultUrl = resultUrl.replacingOccurrences(of: pameter.old, with: pameter.new)
        }
        
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        
        return resultUrl
    }
    
    
}