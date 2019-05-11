//
//  OsmandMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OsmandAllMapsGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let osmandTemplate = OsmandMapsTemplate()
    private let patchTemplates = FilePatchTemplates()
    private let sqlitedbHandler = SqlitedbHandler()
    
    
    public func launch(isShortSet: Bool, isEnglish: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            //print(mapClientLine.id, mapClientLine.shortName)
            
            // Filter off service layers
            guard mapClientLine.forOsmand else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            if !mapClientLine.forRus && !isEnglish {continue}
            if !mapClientLine.forEng && isEnglish {continue}
            
            try generateItem(isShortSet: isShortSet, mapClientLine, mapsServerTable, isEnglish: isEnglish)
        }
    }
    
    
    
    private func generateItem(isShortSet: Bool, _ mapClientLine: MapsClientData, _ mapsServerTable: [MapsServerData], isEnglish: Bool) throws {
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        let filename = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName
        
        
        let currentProjection: Int64 = mapClientLine.projection == 2 ? 1 : 0
        
        
        var url = ""
        var method: String? = nil
        
        if mapClientLine.osmandLoadAnygis {
            url = webTemplates.anygisMapUrl
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

        
        
        
        let minZoom = String(17 - mapServerLine.zoomMax)
        let maxZoom = String(17 - mapServerLine.zoomMin)
        
        var referer: String? = nil
        if mapServerLine.referer.replacingOccurrences(of: " ", with: "") != "" {
            referer = mapServerLine.referer
        }
        
        
        
        var timeSupported: String
        var expireminutes: String
        
        switch mapClientLine.cacheStoringHours {
        case 99999:
            timeSupported = "no"
            expireminutes = "-1"
        case 0:
            timeSupported = "yes"
            expireminutes = "1"
        default:
            timeSupported = "yes"
            expireminutes = String(mapClientLine.cacheStoringHours * 60)
        }
        
        
        
        
        try sqlitedbHandler.createFile(isShortSet: isShortSet,
                                       filename: filename,
                                       zoommin: minZoom,
                                       zoommax: maxZoom,
                                       patch: url,
                                       projection: currentProjection,
                                       method: method,
                                       refererUrl: referer,
                                       timeSupport: timeSupported,
                                       timeStoring: expireminutes,
                                       isEnglish: isEnglish)
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