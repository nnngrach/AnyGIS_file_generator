//
//  OsmandMapsGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OsmandAllMapsGenerator {
    
    private let zipHandler = ZipHandler()
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let osmandTemplate = OsmandMapsTemplate()
    private let patches = FilePathTemplates()
    private let sqlitedbHandler = SqlitedbHandler()
    private let metainfoHandler = MetainfoHandler()
    
    
    public func launch(isShortSet: Bool, isEnglish: Bool, isForSqlitedb: Bool, isPrivateSet: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            //print(mapClientLine.id, mapClientLine.shortName)
            //print(mapClientLine.id, mapClientLine.anygisMapName, mapClientLine.clientMapName)
            
            // Filter off service layers
            if isForSqlitedb && !mapClientLine.forOsmand {continue}
            if !isForSqlitedb && !mapClientLine.forOsmandMeta {continue}
            
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            if !mapClientLine.forRus && !isEnglish {continue}
            if !mapClientLine.forEng && isEnglish {continue}
            if !mapClientLine.visible {continue}
            
            // TODO: Filter private maps
            if !isPrivateSet && mapClientLine.isPrivate {continue}
            if isPrivateSet && !mapClientLine.isPrivate {continue}
            
            if isForSqlitedb {
                try generateSqlitedbItem(isShortSet: isShortSet, mapClientLine, mapsServerTable, isEnglish, isPrivateSet)
            } else {
                try generateMetainfoItem(isShortSet: isShortSet, mapClientLine, mapsServerTable, isEnglish, isPrivateSet)
            }
        }
        
        // Add all files to zip
        if isForSqlitedb {
            zipHandler.zipMapsFolder(sourceShort: patches.localPathToOsmandMapsShort,
                                     SouceFull: patches.localPathToOsmandMapsFull,
                                     zipPath: patches.localPathToOsmandMapsZip,
                                     isShortSet: isShortSet,
                                     isEnglish: isEnglish,
                                     isForFolders: false)
        } else {
            zipHandler.zipMapsFolder(sourceShort: patches.localPathToOsmandMetainfoShort,
                                     SouceFull: patches.localPathToOsmandMetainfoFull,
                                     zipPath: patches.localPathToOsmandMetainfoZip,
                                     isShortSet: isShortSet,
                                     isEnglish: isEnglish,
                                     isForFolders: false)
        }
    }
    
    
    
    
    
    
    private func generateMetainfoItem(isShortSet: Bool, _ mapClientLine: MapsClientData, _ mapsServerTable: [MapsServerData], _ isEnglish: Bool, _ isPrivateSet: Bool) throws {
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        let filename = mapClientLine.groupPrefix + "=" + mapClientLine.clientMapName
        
        
        var isInvertedY = false
        
        if !mapClientLine.osmandMetaLoadAnygis {
            isInvertedY = (mapClientLine.projection == 1)
        }
        
        let isElipsoid = (mapClientLine.projection == 2)
        
        let hasTileSizeUrlTag = mapServerLine.backgroundUrl.contains("{tileSize}")
        let tileSize = (hasTileSizeUrlTag || mapClientLine.isRetina) ? "512" : "256"
        
        var url = ""
        
        if mapClientLine.osmandMetaLoadAnygis {
            url = webTemplates.anygisMapUrlsTemplate
            url = prepareUrlSimple(url: url, mapName: mapServerLine.name)
            if mapServerLine.backgroundUrl.hasPrefix("http://"){
                url = url.replacingOccurrences(of: "https://", with: "http://")
            }
            
        } else {
            url = mapServerLine.backgroundUrl
            url = prepareUrlSimple(url: url, mapName: mapServerLine.name, serverNames: mapServerLine.backgroundServerName)
        }
        
        var serverNames = mapServerLine.backgroundServerName
        serverNames = serverNames.replacingOccurrences(of: ";", with: ",")
        
        let cachingMinutes = getCacheStoringValues(storingHours: mapClientLine.cacheStoringHours)
        
        try metainfoHandler.create(isShortSet: isShortSet,
                                   filename: filename,
                                   zoommin: mapServerLine.zoomMin,
                                   zoommax: mapServerLine.zoomMax,
                                   url: url,
                                   serverNames: serverNames,
                                   isElipsoid: isElipsoid,
                                   isInvertedY: isInvertedY,
                                   isEnglish: isEnglish,
                                   tileSize: tileSize,
                                   defaultTileSize: mapServerLine.dpiHD,
                                   timeSupported: cachingMinutes.timeSupported,
                                   cachingMinutes: cachingMinutes.expireMinutes,
                                   isPrivateSet: isPrivateSet)
    }
    
    
    
    
    
    
    
    private func generateSqlitedbItem(isShortSet: Bool, _ mapClientLine: MapsClientData, _ mapsServerTable: [MapsServerData], _ isEnglish: Bool, _ isPrivateSet: Bool) throws {
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        let filename = mapClientLine.groupPrefix + "=" + mapClientLine.clientMapName
        
        
        
        var isInvertedY: Int64 = 0
        
        if !mapClientLine.osmandLoadAnygis {
            isInvertedY = mapClientLine.projection == 1 ? 1 : 0
        }
        
        
        let isEllipsoid: Int64 = mapClientLine.projection == 2 ? 1 : 0
        
        
        var url = ""

        var serverNames = mapServerLine.backgroundServerName
        serverNames = serverNames.replacingOccurrences(of: ";", with: ",")
        
        if mapClientLine.osmandLoadAnygis {
            url = webTemplates.anygisMapUrlsTemplate
            url = prepareUrlSimple(url: url, mapName: mapServerLine.name)
            
        } else {
            
            url = prepareUrlSimple(url: mapServerLine.backgroundUrl, mapName: mapServerLine.name)
        }

        
        
        
        let minZoom = 17 - mapServerLine.zoomMax
        let maxZoom = 17 - mapServerLine.zoomMin
        
        var referer: String? = nil
        if mapServerLine.referer.replacingOccurrences(of: " ", with: "") != "" {
            referer = mapServerLine.referer
        }
        
        let cachingMinutes = getCacheStoringValues(storingHours: mapClientLine.cacheStoringHours)
        
        
        
        try sqlitedbHandler.createFile(isShortSet: isShortSet,
                                       filename: filename,
                                       zoommin: minZoom,
                                       zoommax: maxZoom,
                                       patch: url,
                                       serverNames: serverNames,
                                       isEllipsoid: isEllipsoid,
                                       isInvertedY: isInvertedY,
                                       refererUrl: referer,
                                       timeSupport: cachingMinutes.timeSupported,
                                       timeStoring: cachingMinutes.expireMinutes,
                                       isEnglish: isEnglish,
                                       isPrivateSet: isPrivateSet,
                                       defaultTileSize: mapServerLine.dpiHD)
    }
    
    
    
    
    
    
    private func prepareUrlSimple(url: String, mapName: String, serverNames: String = "") -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "{1}")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "{2}")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "{0}")
        resultUrl = resultUrl.replacingOccurrences(of: "{-y}", with: "{2}")
        resultUrl = resultUrl.replacingOccurrences(of: "{s}", with: "{rnd}")
        //resultUrl = resultUrl.replacingOccurrences(of: "https", with: "http")
    
        return resultUrl
    }
    
    
    private func prepareUrlForScript(url: String) -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "\" + x + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "\" + y + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "\" + z + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{s}", with: "\" + getServerName(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{-y}", with: "\" + getInvYScript(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{z+1}", with: "\" + getZPlus1(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{x/1024}", with: "\" + getXDiv1024(z,x,y) + \"")
        resultUrl = resultUrl.replacingOccurrences(of: "{y/1024}", with: "\" + getYDiv1024(z,x,y) + \"")
        //resultUrl = resultUrl.replacingOccurrences(of: "https", with: "http")

        return resultUrl
    }
    
    
    // delete?
    private func getServerPartsScript(_ severParts: String) -> String {
        
        //let serverLetters = Array(severParts)
        let serverLetters = severParts.split(separator: ";")
        
        var serverNamesString = ""
        
        for letter in serverLetters {
            serverNamesString.append("\"")
            serverNamesString.append(String(letter))
            serverNamesString.append("\"")
            serverNamesString.append(",")
        }
        
        serverNamesString = String(serverNamesString.dropLast())
        
        return osmandTemplate.getServerPartScript(serverNames: serverNamesString,
                                                  serversCount: serverLetters.count)
    }
    
    
    private func getCacheStoringValues(storingHours: Int64) -> (timeSupported: String, expireMinutes: String){
        var timeSupported: String
        var expireMinutes: String
        
        switch storingHours {
        case 99999:
            timeSupported = "no"
            expireMinutes = "-1"
        case 0:
            timeSupported = "yes"
            expireMinutes = "1"
        default:
            timeSupported = "yes"
            expireMinutes = String(storingHours * 60)
        }
        
        return(timeSupported: timeSupported, expireMinutes: expireMinutes)
    }
    
}
