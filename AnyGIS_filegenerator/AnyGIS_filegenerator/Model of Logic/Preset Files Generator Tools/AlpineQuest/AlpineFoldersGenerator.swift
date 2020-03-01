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
    private let patchTemplates = FilePathTemplates()
    private let alpineTemplates = AlpineMapsTemplates()
    private let alpineLayerGenerator = AlpineMapLayersGenerator()
    private let alpineSavinsPatches = AlpineSavingPatchGenerator()
    private let webTemplates = WebPageTemplates()
    private let zipHandler = ZipHandler()
    
    func createAllFoldersWithMaps(isEnglish: Bool, isShortSet: Bool, isPrivateSet: Bool) throws {
        
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
            if !mapClientLine.visible {continue}
            
            // TODO: Filter private maps
            if !isPrivateSet && mapClientLine.isPrivate {continue}
            if isPrivateSet && !mapClientLine.isPrivate {continue}
            
           
            let mapServerLine = mapsServerTable.filter{$0.name == mapClientLine.anygisMapName}.first!
            
          
            let mapName = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let groupName = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            
            var processedUrl = mapClientLine.alpineLoadAnygis ? webTemplates.anygisMapUrlsTemplate : mapServerLine.backgroundUrl
            
            processedUrl = alpineLayerGenerator.replaceUrlParts(url: processedUrl, mapName: mapClientLine.anygisMapName, parameters: alpineLayerGenerator.urlPartsForReplacement)
            
    
            
            
            if mapClientLine.groupPrefix != previousFolder {
                
                // Last map of the current group.
                // Finish collecting data and write a file.
                if isNotFirstString {
                    finishAndWriteFolder(folderName: previousFolder, content: content, isEnglish: isEnglish, isShortSet: isShortSet, isPrivateSet: isPrivateSet, clientLine: mapClientLine, clientTable: mapsClientTable, serverTable: mapsServerTable)
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
            finishAndWriteFolder(folderName: previousFolder, content: content, isEnglish: isEnglish, isShortSet: isShortSet, isPrivateSet: isPrivateSet, clientLine: mapClientLine, clientTable: mapsClientTable, serverTable: mapsServerTable)
        }
        
        
        
        if !isPrivateSet {
            zipHandler.zipMapsFolder(sourceShort: patchTemplates.localPathToAlpineMapsShort,
            SouceFull: patchTemplates.localPathToAlpineMapsFull,
            zipPath: patchTemplates.localPathToAlpineMapsZip,
            isShortSet: isShortSet,
            isEnglish: isEnglish,
            isForFolders: true)
        }
        
    }
    
    

    
    
    
    private func finishAndWriteFolder(folderName: String, content: String, isEnglish: Bool, isShortSet: Bool, isPrivateSet: Bool, clientLine: MapsClientData, clientTable: [MapsClientData], serverTable: [MapsServerData]) {
        
        let resultContent = content + alpineLayerGenerator.getOutro()
        
        
        let filename = "=" + clientLine.groupPrefix + ".AQX"
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        //let gitHubFolder = isShortSet ? patchTemplates.localPathToAlpineMapsShort : patchTemplates.localPathToAlpineMapsFull
        
        let gitHubFolderPath = getSourcePath(isEnglish: isEnglish, isShortSet: isShortSet, isPrivateSet: isPrivateSet) + filename
        
        let serverFolderPath = patchTemplates.localPathToAlpineMapsInServer + langLabel + filename
        
 
        self.diskHandler.createFile(patch: gitHubFolderPath, content: resultContent, isWithBOM: false)
        
        if !isPrivateSet {
            self.diskHandler.createFile(patch: serverFolderPath, content: resultContent, isWithBOM: false)
        }
    }
    
    
    
    private func getSourcePath(isEnglish: Bool, isShortSet: Bool, isPrivateSet: Bool) -> String {
        
        guard !isPrivateSet else {
            return patchTemplates.localPathToAlpineMapsPrivate + patchTemplates.rusLanguageSubfolder
        }
        
        let gitHubFolder = isShortSet ? patchTemplates.localPathToAlpineMapsShort : patchTemplates.localPathToAlpineMapsFull
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        return gitHubFolder + patchTemplates.groupInOneFileSubfolder + langLabel
    }
    
    
    private func getZipPath(isEnglish: Bool, isShortSet: Bool) -> String {
        
        let zipFolder = patchTemplates.localPathToAlpineMapsZip
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        return zipFolder + langLabel
    }
    
}
