//
//  OsfHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 20.04.2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

class OsfHandler {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let patchTemplates = FilePathTemplates()
    private let textTemplates = OsmandOsfTemplate()
    
    
    var currentCategoryLocalName = ""
    var previousCategoryLocalName = ""
    var previousCategoryPrefix = ""
    
    
    var currentIterationNumber: IterationNumber = .first
    var allGeneratedMapCategories = ""
    var currentCategoryMaps = ""
    
    
    
    public func launch(fileFormat: OsmandMapFormat, isEnglish: Bool) throws {
        
        currentIterationNumber = .first
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            if isItUnnececaryMap(mapClientLine, fileFormat) {continue}
            
            
            currentCategoryLocalName = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            
            savePreviousResultIfItNeeded()
            //updateCurrentCategoryName(mapClientLine, isEnglish)
            
            let osmandMenuPath = mapClientLine.groupNameEng.replacingOccurrences(of: " ", with: "")
            previousCategoryPrefix = osmandMenuPath
            
            if currentIterationNumber == .first {
                previousCategoryLocalName = currentCategoryLocalName
            }
                        
            
            appendToCurrentCategoryMapItem(mapClientLine, fileFormat, isEnglish)
            
            currentIterationNumber = .middle
        }
        
        currentIterationNumber = .last
        savePreviousResultIfItNeeded()
        
        let resultContent = getResultContentWith(allGeneratedMapCategories)
        saveToFile(resultContent, isEnglish)
    }
    
    
    
    
    
    private func isItUnnececaryMap(_ mapClientLine: MapsClientData, _ fileFormat: OsmandMapFormat) -> Bool {
        
        if !mapClientLine.visible {return true}
        if mapClientLine.isPrivate {return true}
        if fileFormat == .sqlitedb && !mapClientLine.forOsmand {return true}
        if fileFormat == .metainfo && !mapClientLine.forOsmandMeta {return true}
        
        //just for testing
        //if (mapClientLine.groupName != "Геологические") && (mapClientLine.groupName != "Инфраструктура") {return true}
        
        return false
    }
    
    
//    private func updateCurrentCategoryName(_ mapClientLine: MapsClientData, _ isEnglish: Bool) {
//        previousCategoryPrefix = mapClientLine.groupPrefix
//        previousCategoryLocalName = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
//    }
    
    
    enum IterationNumber {
        case first, middle, last
    }
    
    
    
    private func savePreviousResultIfItNeeded() {
        
        let isNewCategoryName = (currentCategoryLocalName != previousCategoryLocalName)
        let isFirstIteration = (currentIterationNumber == .first)
        let isFinishingIteration = (currentIterationNumber == .last)
        
        if isFirstIteration {
            //currentCategoryLocalName = previousCategoryLocalName
            return
        }
        
        if isNewCategoryName || isFinishingIteration {

            appendToAllGeneratedCategories(currentCategoryMaps)
            
            previousCategoryLocalName = currentCategoryLocalName
            resetLastIterationData()
        }
    }
    
    
    private func appendToAllGeneratedCategories(_ currentCategoryMaps: String) {
        
        var jsonBlock = textTemplates.oneMapCategory
        
        let categoryPath = previousCategoryPrefix
        let categoryLabel = previousCategoryLocalName
        
        let mapItems = removeLastCommaSymbol(currentCategoryMaps)
        
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$category}", with: categoryPath)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$categoryLabel}", with: categoryLabel)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$mapItems}", with: mapItems)
        
        allGeneratedMapCategories.append(jsonBlock)
    }
    
    
    
    private func resetLastIterationData() {
        currentCategoryMaps = ""
    }
    
    
    private func appendToCurrentCategoryMapItem(_ mapClientLine: MapsClientData, _ fileFormat: OsmandMapFormat, _ isEnglish: Bool) {
        
        var mapItem = textTemplates.oneMapItem
        
        let firstNamePart = isEnglish ? mapClientLine.emojiGroupEn : mapClientLine.emojiGroupRu
        let secondNamePart = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
        let nameLabel = firstNamePart + " " + secondNamePart
        
        
        var format = ""
        var extantion = ""
        
        if fileFormat == .sqlitedb {
            format = "sqlite"
            extantion = ".sqlitedb"
        } else {
            //TODO: not shure about this
            format = "metainfo"
            extantion = ".metainfo"
        }
        
        
        let fileName = nameLabel + extantion
        
        

        let lang = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        var url = patchTemplates.gitOsmadMapsFolder + lang + "=" + mapClientLine.groupPrefix + "=" + mapClientLine.clientMapName + extantion
        url = url.replacingOccurrences(of: "=", with: "%3D")
        url = url.replacingOccurrences(of: "/", with: "\\/")
        
        
        let timestamp = String( Int( NSDate().timeIntervalSince1970 ) )
        
        
        mapItem = mapItem.replacingOccurrences(of: "{$mapLabel}", with: nameLabel)
        mapItem = mapItem.replacingOccurrences(of: "{$fileFormat}", with: format)
        mapItem = mapItem.replacingOccurrences(of: "{$timestamp}", with: timestamp)
        mapItem = mapItem.replacingOccurrences(of: "{$filename}", with: fileName)
        mapItem = mapItem.replacingOccurrences(of: "{$downloadurl}", with: url)
        
        currentCategoryMaps.append(mapItem)
    }
    
    
    
    
    private func getResultContentWith(_ allGeneratedMapCategories: String) -> String {
        let categoryItems = removeLastCommaSymbol(allGeneratedMapCategories)
        var jsonBlock = textTemplates.wholePluginTemplate
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$mapCategories}", with: categoryItems)
        return jsonBlock
    }
    
    
    private func saveToFile(_ content: String, _ isEnglish: Bool) {
        let lang = isEnglish ? "en/" : "ru/"
        let filename = "items.json"
        let path = patchTemplates.localPathToOsmandOsf + lang + filename
        diskHandler.createFile(patch: path, content: content, isWithBOM: false)
    }
    
    
    
    
    private func removeLastCommaSymbol(_ currentCategoryMaps: String) -> String {
        return String(currentCategoryMaps.dropLast())
    }
    
    
    
    
    
    
    
    
    
    //TODO: delete old code
    
    private var allMapsObjects: [OsmandOsfMap] = []
    
    public func reset() {
        allMapsObjects = []
    }
    
    
    public func addMap(dto: OsmandGeneratorDTO) throws {
        
        let currentMap = OsmandOsfMap(
            name: dto.label,
            url: dto.url,
            randoms: dto.serverNames,
            referer: dto.refererUrl ?? "",
            minZoom: Int(dto.zoommin),
            maxZoom: Int(dto.zoommax),
            ellipsoid: dto.isEllipsoid,
            inverted_y: dto.isInvertedY,
            inversiveZoom: false,
            timesupported: dto.timeSupport == "yes",
            expire: Int(dto.timeStoring) ?? 2160,
            tileSize: Int(dto.defaultTileSize) ?? 256,
            bitDensity: 8,
            avgSize: 18000,
            ext: ".png",
            sql: false)
        
        allMapsObjects.append(currentMap)
    }
    
    
    public func getAllMapsJson() -> String {
        let encodedData = try? JSONEncoder().encode(allMapsObjects)
        let jsonString = String(data: encodedData ?? Data(),
                                encoding: .utf8)
        return jsonString ?? ""
    }
    
}

