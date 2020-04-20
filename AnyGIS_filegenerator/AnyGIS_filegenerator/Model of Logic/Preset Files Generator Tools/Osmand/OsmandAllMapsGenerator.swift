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
    private let osfHandler = OsfHandler()
    
    
    public func launch(isShortSet: Bool, isEnglish: Bool, fileFormat: OsmandMapFormat, isPrivateSet: Bool) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        resetAll()
        
        for mapClientLine in mapsClientTable {
            
            if isItUnnececaryMap(fileFormat, isShortSet, isEnglish, isPrivateSet, mapClientLine: mapClientLine) {continue}

            let mapData = prepareMapDate( isShortSet, isEnglish, fileFormat, mapClientLine, mapsServerTable, isPrivateSet)
            
            switch fileFormat {
            case .sqlitedb:
                try sqlitedbHandler.createFile(dto: mapData)
            case .metainfo:
                try metainfoHandler.create(dto: mapData)
            case .osf:
                try osfHandler.addMap(dto: mapData)
                //break
            }
        }
        
        // Add all files to zip
        
        switch fileFormat {
        case .sqlitedb:
            zipHandler.zipMapsFolder(sourceShort: patches.localPathToOsmandMapsShort,
                                    SouceFull: patches.localPathToOsmandMapsFull,
                                    zipPath: patches.localPathToOsmandMapsZip,
                                    isShortSet: isShortSet,
                                    isEnglish: isEnglish,
                                    isForFolders: false)
        case .metainfo:
            zipHandler.zipMapsFolder(sourceShort: patches.localPathToOsmandMetainfoShort,
                                    SouceFull: patches.localPathToOsmandMetainfoFull,
                                    zipPath: patches.localPathToOsmandMetainfoZip,
                                    isShortSet: isShortSet,
                                    isEnglish: isEnglish,
                                    isForFolders: false)
        case .osf:
            let result = osfHandler.getAllMapsJson()
            print(result)
            break
        }
        
    }
    
    
    
    private func resetAll() {
        osfHandler.reset()
    }
    
    
    
    private func isItUnnececaryMap(_ fileFormat: OsmandMapFormat, _ isShortSet: Bool, _ isEnglish: Bool, _ isPrivateSet: Bool, mapClientLine: MapsClientData) -> Bool {
        
        //for OSF testing
        //if mapClientLine.groupName != "Спутниковые" {return true}
        //if mapClientLine.id != 2050003 {return true}
        
        
        
        // Filter off service layers
        if fileFormat == .sqlitedb && !mapClientLine.forOsmand {return true}
        if fileFormat == .metainfo && !mapClientLine.forOsmandMeta {return true}
        if fileFormat == .osf && !mapClientLine.forOsmand {return true}
        
        // Filter for short list
        if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {return true}
        if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {return true}
        if !mapClientLine.forRus && !isEnglish {return true}
        if !mapClientLine.forEng && isEnglish {return true}
        if !mapClientLine.visible {return true}
        
        // TODO: Filter private maps
        if !isPrivateSet && mapClientLine.isPrivate {return true}
        if isPrivateSet && !mapClientLine.isPrivate {return true}
        
        return false
    }
    
    
    private func prepareMapDate(_ isShortSet: Bool, _ isEnglish: Bool, _ fileFormat: OsmandMapFormat, _ mapClientLine: MapsClientData, _ mapsServerTable: [MapsServerData],  _ isPrivateSet: Bool) -> OsmandGeneratorDTO {
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        
        var label = ""
        
        if isEnglish {
            label = mapClientLine.emojiGroupEn + " " + mapClientLine.shortNameEng
        } else {
            label = mapClientLine.emojiGroupRu + " " + mapClientLine.shortName
        }
        
        let filename = mapClientLine.groupPrefix + "=" + mapClientLine.clientMapName
        
        let isUsingAnygisProxy = checkIfIsUsingAnygisProxy(fileFormat, mapClientLine)
        let url = getUrl(isUsingAnygisProxy, mapServerLine)
        let serverNames = getServerNames(mapServerLine)
        let referer = getReferer(mapServerLine)
        
        let isInvertedY = checkIfIsInvertedY(isUsingAnygisProxy, mapClientLine)
        let isElipsoid = (mapClientLine.projection == 2)
        let tileSize = checkTileSize(mapServerLine, mapClientLine)
        let cachingMinutes = getCacheStoringValues(storingHours: mapClientLine.cacheStoringHours)
        
        return OsmandGeneratorDTO(label: label, filename: filename, zoommin: mapServerLine.zoomMin, zoommax: mapServerLine.zoomMax, url: url, serverNames: serverNames, refererUrl: referer, isEllipsoid: isElipsoid, isInvertedY: isInvertedY, tileSize: tileSize, defaultTileSize: mapServerLine.dpiHD, timeSupport: cachingMinutes.timeSupported, timeStoring: cachingMinutes.expireMinutes, cachingMinutes: cachingMinutes.expireMinutes, isEnglish: isEnglish, isShortSet: isShortSet, isPrivateSet: isPrivateSet)
    }
  
    
    
    private func checkIfIsUsingAnygisProxy(_ fileFormat: OsmandMapFormat, _ mapClientLine: MapsClientData) -> Bool {
        
        switch fileFormat {
        case .sqlitedb:
            return mapClientLine.osmandLoadAnygis
        case .metainfo:
            return mapClientLine.osmandMetaLoadAnygis
        case .osf:
            return mapClientLine.osmandLoadAnygis
        }
        
        //return (fileFormat == .sqlitedb && mapClientLine.osmandLoadAnygis) || (fileFormat == .metainfo && mapClientLine.osmandMetaLoadAnygis)
    }
    
    
    
    
    
    
    private func getUrl(_ isUsingAnygisProxy: Bool, _ mapServerLine: MapsServerData) -> String {
        
        var url = ""
        
        if isUsingAnygisProxy {
            url = webTemplates.anygisMapUrlsTemplate
            url = prepareUrlSimple(url: url, mapName: mapServerLine.name, tilesizeHD: mapServerLine.dpiHD)
            if mapServerLine.backgroundUrl.hasPrefix("http://"){
                url = url.replacingOccurrences(of: "https://", with: "http://")
            }
            
        } else {
            url = mapServerLine.backgroundUrl
            url = prepareUrlSimple(url: url, mapName: mapServerLine.name, serverNames: mapServerLine.backgroundServerName, tilesizeHD: mapServerLine.dpiHD)
        }
        
        return url
    }
    
    
    private func prepareUrlSimple(url: String, mapName: String, serverNames: String = "", tilesizeHD: String) -> String {
        
        var resultUrl = url
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        resultUrl = resultUrl.replacingOccurrences(of: "{x}", with: "{1}")
        resultUrl = resultUrl.replacingOccurrences(of: "{y}", with: "{2}")
        resultUrl = resultUrl.replacingOccurrences(of: "{z}", with: "{0}")
        resultUrl = resultUrl.replacingOccurrences(of: "{-y}", with: "{2}")
        resultUrl = resultUrl.replacingOccurrences(of: "{s}", with: "{rnd}")
        
        //Always use max size of tile if it exists.
        resultUrl = resultUrl.replacingOccurrences(of: "{tileSize}", with: tilesizeHD)
        
        //resultUrl = resultUrl.replacingOccurrences(of: "https", with: "http")
    
        return resultUrl
    }
    
    
    
    
    private func getServerNames(_ mapServerLine: MapsServerData) -> String {
        
        return mapServerLine.backgroundServerName.replacingOccurrences(of: ";", with: ",")
    }
    
    
    private func getReferer (_ mapServerLine: MapsServerData) -> String? {
        
        var referer: String? = nil
        if mapServerLine.referer.replacingOccurrences(of: " ", with: "") != "" {
            referer = mapServerLine.referer
        }
        return referer
    }
    
    
    private func checkTileSize(_ mapServerLine: MapsServerData, _ mapClientLine: MapsClientData) -> String {
        
        let hasTileSizeUrlTag = mapServerLine.backgroundUrl.contains("{tileSize}")
        return (hasTileSizeUrlTag || mapClientLine.isRetina) ? "512" : "256"
    }
    
    
    
    private func checkIfIsInvertedY(_ isUsingAnygisProxy: Bool, _ mapClientLine: MapsClientData) -> Bool {
        
        var isInvertedY = false
        
        if !isUsingAnygisProxy {
            isInvertedY = (mapClientLine.projection == 1)
        }
        
        return isInvertedY
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
