//
//  OsfHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 20.04.2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

class OsfHandler {
    
    private let zipHandler = ZipHandler()
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let patchTemplates = FilePathTemplates()
    private let textTemplates = OsmandOsfTemplate()
    
    
    var currentCategoryNameEn = ""
    var currentCategoryNameRu = ""
    var previousCategoryNameEn = ""
    var previousCategoryNameRu = ""
    var previousCategoryPrefix = ""
    
    
    var currentIterationNumber: IterationNumber = .first
    var allGeneratedMapCategories = ""
    var currentCategoryMaps = ""
    
    
    
    public func launch(fileFormat: OsmandMapFormat, isEnglish: Bool) throws {
        
        currentIterationNumber = .first
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            if isItUnnececaryMap(mapClientLine, fileFormat, isEnglish) {continue}
            
            
            currentCategoryNameEn = mapClientLine.groupNameEng
            currentCategoryNameRu = mapClientLine.groupName
            
            savePreviousResultIfItNeeded()
            //updateCurrentCategoryName(mapClientLine, isEnglish)
            
            let osmandMenuPath = mapClientLine.groupNameEng.replacingOccurrences(of: " ", with: "")
            previousCategoryPrefix = osmandMenuPath
            
            if currentIterationNumber == .first {
                previousCategoryNameEn = currentCategoryNameEn
                previousCategoryNameRu = currentCategoryNameRu
            }
                        
            
            appendToCurrentCategoryMapItem(mapClientLine, fileFormat, isEnglish)
            
            currentIterationNumber = .middle
        }
        
        currentIterationNumber = .last
        savePreviousResultIfItNeeded()
        
        let resultContent = getResultContentWith(allGeneratedMapCategories)
        saveResult(resultContent, isEnglish)
    }
    
    
    
    
    
    private func isItUnnececaryMap(_ mapClientLine: MapsClientData, _ fileFormat: OsmandMapFormat, _ isEnglish: Bool) -> Bool {
        
        if !mapClientLine.visible {return true}
        if mapClientLine.isPrivate {return true}
        if fileFormat == .sqlitedb && !mapClientLine.forOsmand {return true}
        if fileFormat == .metainfo && !mapClientLine.forOsmandMeta {return true}
        //if isEnglish && !mapClientLine.forEng {return true}
        //if !isEnglish && !mapClientLine.forRus {return true}
        
        
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
        
        let isNewCategoryName = (currentCategoryNameEn != previousCategoryNameEn)
        let isFirstIteration = (currentIterationNumber == .first)
        let isFinishingIteration = (currentIterationNumber == .last)
        
        if isFirstIteration {
            //currentCategoryLocalName = previousCategoryLocalName
            return
        }
        
        if isNewCategoryName || isFinishingIteration {

            appendToAllGeneratedCategories(currentCategoryMaps)
            
            previousCategoryNameEn = currentCategoryNameEn
            previousCategoryNameRu = currentCategoryNameRu
            resetLastIterationData()
        }
    }
    
    
    private func appendToAllGeneratedCategories(_ currentCategoryMaps: String) {
        
        var jsonBlock = textTemplates.oneMapCategory
        
        let categoryPath = previousCategoryPrefix
        
        let mapItems = removeLastCommaSymbol(currentCategoryMaps)
        
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$category}", with: categoryPath)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$categoryLabelEn}", with: previousCategoryNameEn)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$categoryLabelRu}", with: previousCategoryNameRu)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$mapItems}", with: mapItems)
        
        allGeneratedMapCategories.append(jsonBlock)
    }
    
    
    
    private func resetLastIterationData() {
        currentCategoryMaps = ""
    }
    
    
    private func appendToCurrentCategoryMapItem(_ mapClientLine: MapsClientData, _ fileFormat: OsmandMapFormat, _ isEnglish: Bool) {
        
        var mapItem = textTemplates.oneMapItem
        
        let nameLabelRu = mapClientLine.emojiGroupRu + " " + mapClientLine.shortName
        let nameLabelEn = mapClientLine.emojiGroupEn + " " + mapClientLine.shortNameEng
        
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
        
        
        let fileNameEn = nameLabelEn + extantion
        let fileNameRu = nameLabelRu + extantion
        
        

        let lang = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        var url = patchTemplates.gitOsmadMapsFolder + lang + "=" + mapClientLine.groupPrefix + "=" + mapClientLine.clientMapName + extantion
        url = url.replacingOccurrences(of: "=", with: "%3D")
        url = url.replacingOccurrences(of: "/", with: "\\/")
        
        
        let tileUrl = getPreviewTileUrl(mapClientLine)
        
        //let timestamp = String( Int( NSDate().timeIntervalSince1970 ) )
        let timestamp = String(mapClientLine.lastUpdateTime)
        
        mapItem = mapItem.replacingOccurrences(of: "{$mapLabelEn}", with: nameLabelEn)
        mapItem = mapItem.replacingOccurrences(of: "{$mapLabelRu}", with: nameLabelRu)
        mapItem = mapItem.replacingOccurrences(of: "{$fileFormat}", with: format)
        mapItem = mapItem.replacingOccurrences(of: "{$timestamp}", with: timestamp)
        mapItem = mapItem.replacingOccurrences(of: "{$filenameEn}", with: fileNameEn)
        mapItem = mapItem.replacingOccurrences(of: "{$filenameRu}", with: fileNameRu)
        mapItem = mapItem.replacingOccurrences(of: "{$downloadurl}", with: url)
        mapItem = mapItem.replacingOccurrences(of: "{$imagePreview}", with: tileUrl)
        
        currentCategoryMaps.append(mapItem)
    }
    
    
    
    
    private func getPreviewTileUrl(_ mapClientLine: MapsClientData) -> String {
        return "https://anygis.ru/api/v1/previewTile/" + mapClientLine.anygisMapName
    }
    
    
    
    private func getResultContentWith(_ allGeneratedMapCategories: String) -> String {
        let categoryItems = removeLastCommaSymbol(allGeneratedMapCategories)
        var jsonBlock = textTemplates.wholePluginTemplate
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$mapCategories}", with: categoryItems)
        return jsonBlock
    }
    
    
    
    private func saveResult(_ content: String, _ isEnglish: Bool) {
        saveToFile(content, isEnglish)
        copyStaticFiles()
        createObfFile()
    }
    
    private func saveToFile(_ content: String, _ isEnglish: Bool) {
        let filename = "items.json"
        let path = patchTemplates.localPathToOsmandOsfFiles + filename
        diskHandler.createFile(patch: path, content: content, isWithBOM: false)
    }
    
    private func copyStaticFiles() {
        diskHandler.secureCopyItem(at: patchTemplates.localPathToOsmandOsfStaticFiles + "full_collection.json", to: patchTemplates.localPathToOsmandOsfFiles + "full_collection.json")
        diskHandler.secureCopyItem(at: patchTemplates.localPathToOsmandOsfStaticFiles + "res", to: patchTemplates.localPathToOsmandOsfFiles + "res")
    }
    
    private func createObfFile() {
        zipHandler.zipWithoutParentFolder(sourcePath: patchTemplates.localPathToOsmandOsfFiles, archievePath: patchTemplates.localPathToOsmandOsfPluginFolder + "Online_maps_collection_anygis.osf")
    }
    
    
    
    
    private func removeLastCommaSymbol(_ currentCategoryMaps: String) -> String {
        return String(currentCategoryMaps.dropLast())
    }
    
}
