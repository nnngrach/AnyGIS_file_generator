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
    
    enum IterationNumber {
        case first, middle, last
    }
    
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
        
        //let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        let mapsClientTable = try baseHandler.getMapsClientDataForOsf()
        
        for mapClientLine in mapsClientTable {
            
            if isItUnnececaryMap(mapClientLine, fileFormat, isEnglish) {continue}
            
            updateCurrentStepData(mapClientLine)
            savePreviousResultIfItNeeded()
            updatePreviousStepData(mapClientLine)
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
        
        return false
    }
    
    
    private func updateCurrentStepData(_ mapClientLine: MapsClientData) {
        currentCategoryNameEn = mapClientLine.groupNameEng
        currentCategoryNameRu = mapClientLine.groupName
    }
    
    
    private func updatePreviousStepData(_ mapClientLine: MapsClientData) {
        let osmandMenuPath = mapClientLine.groupNameEng.replacingOccurrences(of: " ", with: "")
        previousCategoryPrefix = osmandMenuPath
        
        if currentIterationNumber == .first {
            previousCategoryNameEn = currentCategoryNameEn
            previousCategoryNameRu = currentCategoryNameRu
        }
    }
    
    
    
    
    
    private func savePreviousResultIfItNeeded() {
        
        let isNewCategoryName = (currentCategoryNameEn != previousCategoryNameEn)
        let isFirstIteration = (currentIterationNumber == .first)
        let isFinishingIteration = (currentIterationNumber == .last)
        
        if isFirstIteration {return}
        
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
        
        let categoryEn = previousCategoryNameEn.replacingOccurrences(of: "Overlay", with: "Layer")
        let categoryRu = previousCategoryNameRu.replacingOccurrences(of: "Overlay", with: "Layer")
        
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$category}", with: categoryPath)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$categoryLabelEn}", with: categoryEn)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$categoryLabelRu}", with: categoryRu)
        jsonBlock = jsonBlock.replacingOccurrences(of: "{$mapItems}", with: mapItems)
        
        allGeneratedMapCategories.append(jsonBlock)
    }
    
    
    
    private func resetLastIterationData() {
        currentCategoryMaps = ""
    }
    
    
    private func appendToCurrentCategoryMapItem(_ mapClientLine: MapsClientData, _ fileFormat: OsmandMapFormat, _ isEnglish: Bool) {
        
        var mapItem = textTemplates.oneMapItem
        
        //let nameLabelRu = mapClientLine.emojiGroupRu + " " + mapClientLine.shortName
        //let nameLabelEn = mapClientLine.emojiGroupEn + " " + mapClientLine.shortNameEng
        let nameLabelRu = mapClientLine.osfPrefix + " " + mapClientLine.shortName
        let nameLabelEn = mapClientLine.osfPrefix + " " + mapClientLine.shortNameEng
        
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
        
        let date = getDateStringFrom(timestamp: mapClientLine.lastUpdateTime)
        let timestamp = String(mapClientLine.lastUpdateTime)
        
        let firstsubnameEn = mapClientLine.regionNameEn.count > 2 ? mapClientLine.regionNameEn : "Global"
        let firstsubnameRu = mapClientLine.regionNameRu.count > 2 ? mapClientLine.regionNameRu : "Глобальное покрытие"
        let secondsubnameEn = mapClientLine.subregionNameEn.count > 2 ? mapClientLine.subregionNameEn : ""
        let secondsubnameRu = mapClientLine.subregionNameRu.count > 2 ? mapClientLine.subregionNameRu : ""
        
        let mapServerLine = baseHandler.getMapsServerDataBy(name: mapClientLine.anygisMapName)!
        let descriptionEn = textTemplates.getDescriptionEn(mapClientLine, mapServerLine, date)
        let descriptionRu = textTemplates.getDescriptionEn(mapClientLine, mapServerLine, date)

        
        mapItem = mapItem.replacingOccurrences(of: "{$mapLabelEn}", with: nameLabelEn)
        mapItem = mapItem.replacingOccurrences(of: "{$mapLabelRu}", with: nameLabelRu)
        mapItem = mapItem.replacingOccurrences(of: "{$fileFormat}", with: format)
        mapItem = mapItem.replacingOccurrences(of: "{$date}", with: date)
        mapItem = mapItem.replacingOccurrences(of: "{$timestamp}", with: timestamp)
        mapItem = mapItem.replacingOccurrences(of: "{$filenameEn}", with: fileNameEn)
        mapItem = mapItem.replacingOccurrences(of: "{$filenameRu}", with: fileNameRu)
        mapItem = mapItem.replacingOccurrences(of: "{$downloadurl}", with: url)
        mapItem = mapItem.replacingOccurrences(of: "{$imagePreview}", with: tileUrl)
        mapItem = mapItem.replacingOccurrences(of: "{$firstsubnameEn}", with: firstsubnameEn)
        mapItem = mapItem.replacingOccurrences(of: "{$firstsubnameRu}", with: firstsubnameRu)
        mapItem = mapItem.replacingOccurrences(of: "{$secondsubnameEn}", with: secondsubnameEn)
        mapItem = mapItem.replacingOccurrences(of: "{$secondsubnameRu}", with: secondsubnameRu)
        mapItem = mapItem.replacingOccurrences(of: "{$descriptionEn}", with: descriptionEn)
        mapItem = mapItem.replacingOccurrences(of: "{$descriptionRu}", with: descriptionRu)
        
        currentCategoryMaps.append(mapItem)
    }
    
    
    private func getDateStringFrom(timestamp: Int64) -> String{
        let format = "dd.MM.yyyy"
        let date = Date(timeIntervalSince1970: Double(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateResult = formatter.string(from: date as Date)
        return dateResult
    }
    
    
    
    private func getPreviewTileUrl(_ mapClientLine: MapsClientData) -> String {
        return "https://anygis.ru/api/v1/previewRowOfTiles/" + mapClientLine.anygisMapName
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
        diskHandler.secureCopyItem(at: patchTemplates.localPathToOsmandOsfStaticFiles + "res", to: patchTemplates.localPathToOsmandOsfFiles + "res")
        //diskHandler.secureCopyItem(at: patchTemplates.localPathToOsmandOsfStaticFiles + "full_collection.json", to: patchTemplates.localPathToOsmandOsfFiles + "full_collection.json")
    }
    
    private func createObfFile() {
        zipHandler.zipWithoutParentFolder(sourcePath: patchTemplates.localPathToOsmandOsfFiles, archievePath: patchTemplates.localPathToOsmandOsfPluginFolder + "Online_maps_collection_anygis.osf")
    }
    
    
    
    
    private func removeLastCommaSymbol(_ currentCategoryMaps: String) -> String {
        return String(currentCategoryMaps.dropLast())
    }
    
}
