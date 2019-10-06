//
//  AlpineFolderGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 06/10/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AlpineFoldersGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let patchTemplates = FilePatchTemplates()
    private let alpineTemplates = AlpineMapsTemplates()
    private let alpineLayerGenerator = AlpineMapLayersGenerator()
    private let alpineSavinsPatches = AlpineSavingPatchGenerator()
    
    
    func createAllFoldersWithMaps(isEnglish: Bool, isShortSet: Bool) throws {
        
        var content = ""
        var previousFolder = ""
        var isNotFirstString = false
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
        
            // Filter off service layers
            guard mapClientLine.forAlpine else {continue}
            
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            if !mapClientLine.forRus && !isEnglish {continue}
            if !mapClientLine.forEng && isEnglish {continue}
            
            
            
            let mapServerLine = mapsServerTable.filter{$0.name == mapClientLine.anygisMapName}.first!
            
            //let mapFileName = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName
            
            let mapName = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let groupName = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            let processedUrl = alpineLayerGenerator.replaceUrlParts(url: mapServerLine.backgroundUrl, mapName: mapClientLine.anygisMapName, parameters: alpineLayerGenerator.urlPartsForReplacement)
            
            
            if mapClientLine.groupPrefix != previousFolder {
                
                // Last map of the current group.
                // Finish collecting data and write a file.
                if isNotFirstString {
                    finishAndWriteFolder(folderName: previousFolder, content: content, isEnglish: isEnglish, isShortSet: isShortSet, clientLine: mapClientLine, clientTable: mapsClientTable, serverTable: mapsServerTable)
                }
                
                // Start collecting data for next group
                isNotFirstString = true
                previousFolder = mapClientLine.groupPrefix
                
               
                let intro = alpineLayerGenerator.getIntro(groupName: groupName)
                
                let oneMapData = alpineLayerGenerator.generateOneLayerContent(mapName, groupName, processedUrl, mapServerLine.backgroundServerName, mapClientLine.layersIDList, mapClientLine.isRetina, isEnglish, .Alpine, mapClientLine, mapServerLine, mapClientLine.id)
                
                content = intro + oneMapData
                
            } else {
                
                // Just add current map to group
                content += alpineLayerGenerator.generateOneLayerContent(mapName, groupName, processedUrl, mapServerLine.backgroundServerName, mapClientLine.layersIDList, mapClientLine.isRetina, isEnglish, .Alpine, mapClientLine, mapServerLine, mapClientLine.id)
            }
            
            // For last iteration: write collected data to last file
            finishAndWriteFolder(folderName: previousFolder, content: content, isEnglish: isEnglish, isShortSet: isShortSet, clientLine: mapClientLine, clientTable: mapsClientTable, serverTable: mapsServerTable)
        }
        
    }
    
    
    
    private func finishAndWriteFolder(folderName: String, content: String, isEnglish: Bool, isShortSet: Bool, clientLine: MapsClientData, clientTable: [MapsClientData], serverTable: [MapsServerData]) {
        
        let resultContent = content + alpineLayerGenerator.getOutro()
        
        
        let filename = "_" + clientLine.groupPrefix + ".AQX"
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        let gitHubFolder = isShortSet ? patchTemplates.localPathToAlpineMapsShort : patchTemplates.localPathToAlpineMapsFull
        
        let gitHubFolderPath = gitHubFolder + langLabel + filename
        
        let serverFolderPath = patchTemplates.localPathToAlpineMapsInServer + langLabel + filename
        
 
        self.diskHandler.createFile(patch: gitHubFolderPath, content: resultContent)
        self.diskHandler.createFile(patch: serverFolderPath, content: resultContent)
    }
    
}
