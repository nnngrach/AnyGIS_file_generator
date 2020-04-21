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
    
    
    var previousCategoryName = ""
    var currentCategoryName = ""
    
    var isItFirstIteration = true
    var allGeneratedMapCategories = ""
    var currentCategoryMaps = ""
    
    
    public func launch(fileFormat: OsmandMapFormat, isEnglish: Bool) throws {
        
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
    
        for mapClientLine in mapsClientTable {
            
            if isItUnnececaryMap(mapClientLine, fileFormat) {continue}
            
            updateCurrentCategoryName(mapClientLine)
            savePreviousResultIfItNeeded()
            
            appendToCurrentCategoryMapItem(mapClientLine, fileFormat, isEnglish)
            
            isItFirstIteration = false
        }
        
        savePreviousResultIfItNeeded()
        
        let resultContent = getResultContentWith(allGeneratedMapCategories)
        saveToFile(resultContent)
    }
    
    
    
    
    
    private func isItUnnececaryMap(_ mapClientLine: MapsClientData, _ fileFormat: OsmandMapFormat) -> Bool {
        
        if !mapClientLine.visible {return true}
        if !mapClientLine.isPrivate {return true}
        if fileFormat == .sqlitedb && !mapClientLine.forOsmand {return true}
        if fileFormat == .metainfo && !mapClientLine.forOsmandMeta {return true}
        
        return false
    }
    
    
    private func updateCurrentCategoryName(_ mapClientLine: MapsClientData) {
        currentCategoryName = mapClientLine.groupNameEng
    }
    
    private func savePreviousResultIfItNeeded() {
        
        if previousCategoryName != currentCategoryName {
            previousCategoryName  = currentCategoryName
            if isItFirstIteration {return}
            
            appendToAllGeneratedCategories(currentCategoryMaps)
            resetLastIterationData()
        }
    }
    
    
    private func appendToAllGeneratedCategories(_ currentCategoryMaps: String) {
        let mapItems = removeLastCommaSymbol(currentCategoryMaps)
        var jsonBlock = textTemplates.oneMapCategory
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$mapItems}", with: mapItems)
        allGeneratedMapCategories.append(jsonBlock)
    }
    
    
    
    private func resetLastIterationData() {
        currentCategoryMaps = ""
    }
    
    
    private func appendToCurrentCategoryMapItem(_ mapClientLine: MapsClientData, _ fileFormat: OsmandMapFormat, _ isEnglish: Bool) {
        
        var mapItem = textTemplates.oneMapItem
        
        let firstNamePart = isEnglish ? mapClientLine.emojiGroupEn : mapClientLine.emojiGroupEn
        let secondNamePart = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
        let nameLabel = firstNamePart + " " + secondNamePart
        
        
        mapItem = mapItem.replacingOccurrences(of: "{$mapLabel}", with: nameLabel)

    }
    
    
    
    
    private func getResultContentWith(_ allGeneratedMapCategories: String) -> String {
        let categoryItems = removeLastCommaSymbol(allGeneratedMapCategories)
        var jsonBlock = textTemplates.wholePluginTemplate
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$mapCategories}", with: categoryItems)
        return jsonBlock
    }
    
    
    private func saveToFile(_ content: String) {
        // saving json
        print(content)
    }
    
    
    
    
    private func removeLastCommaSymbol(_ currentCategoryMaps: String) -> String {
        return String(currentCategoryMaps.dropLast())
    }
    
    
    
    
    
    
    //=================Old
    
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

