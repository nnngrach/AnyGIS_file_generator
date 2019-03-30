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
    private let osmandTemplate = OsmandMapsTemplate()
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
        
        
        let currentProjection: Int64 = mapClientLine.projection == 2 ? 1 : 0
        
        
        
        var url = ""
        var method: String? = nil
        
        if mapClientLine.osmandLoadAnygis {
            url = webTemplates.anygisMapUrlHttp
            url = prepareUrlSimple(url: url, mapName: mapServerLine.name)
            
        } else if mapClientLine.projection == 0 && mapServerLine.backgroundServerName == "" {
            url = mapServerLine.backgroundUrl
            url = prepareUrlSimple(url: url, mapName: mapServerLine.name)
            
        } else {
            method = osmandTemplate.readAsScriptMethod
            var urlString = mapServerLine.backgroundUrl
            
            
            if urlString.contains("{s}") {
                if mapServerLine.backgroundServerName == "wikimapia" {
                    url += osmandTemplate.getWikiScript()
                } else {
                    url += getServerPartsScript(mapServerLine.backgroundServerName)
                }
            }
            
            if urlString.contains("{invY}") {
                url += osmandTemplate.getInvYScript
            }
            
            if urlString.contains("{sasZ}") {
                url += osmandTemplate.getSasZ
            }
            
            if urlString.contains("{folderX}") {
                url += osmandTemplate.getSasX
            }
            
            if urlString.contains("{folderY}") {
                url += osmandTemplate.getSasY
            }
            
            urlString = prepareUrlForScript(url: urlString)
            
            url += osmandTemplate.getUrlScript(url: urlString)
        }

        
        
        
        let minZoom = String(mapServerLine.zoomMin - 3)
        let maxZoom = String(mapServerLine.zoomMax - 3)
        
        
        
        
        
        
        try sqlitedbHandler.createFile(isShortSet: isShortSet,
                                       filename: filename,
                                       zoommin: minZoom,
                                       zoommax: maxZoom,
                                       patch: url,
                                       projection: currentProjection,
                                       method: method)
    }
    
    
    
    private func prepareUrlSimple(url: String, mapName: String) -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "{1}")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "{2}")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "{0}")
        resultUrl = resultUrl.replacingOccurrences(of: "{invY}", with: "{2}")
        return resultUrl
    }
    
    
    private func prepareUrlForScript(url: String) -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "\" + x + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "\" + y + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "\" + z + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{s}", with: "\" + getServerName(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{invY}", with: "\" + getInvYScript(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{sasZ}", with: "\" + getSasZ(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{folderX}", with: "\" + getSasX(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{folderY}", with: "\" + getSasY(z,x,y) + \"")

        return resultUrl
    }
    
    
    
    private func getServerPartsScript(_ severParts: String) -> String {
        
        let serverLetters = Array(severParts)
        
        var serverNamesString = ""
        
        for letter in serverLetters {
            serverNamesString.append("\"")
            serverNamesString.append(letter)
            serverNamesString.append("\"")
            serverNamesString.append(",")
        }
        
        serverNamesString = String(serverNamesString.dropLast())
        
        return osmandTemplate.getServerPartScript(serverNames: serverNamesString,
                                                  serversCount: serverLetters.count)
    }
    
}
