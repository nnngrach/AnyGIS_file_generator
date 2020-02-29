//
//  AbstractGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 13/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AbstractAllMapsGenerator {
    
    private let baseHandler = SqliteHandler()
    private let diskHandler = DiskHandler()
    private let zipHandler = ZipHandler()
    
    public var oneMapGenerator: AbstractOneMapGenerator {
        return AbstractOneMapGenerator()
    }
    
    public var patchGenerator: AbstractSavingPatchGenerator {
        return AbstractSavingPatchGenerator()
    }
    
    public var isAllMapsInOneFile: Bool {
        return false
    }

    
    
    
    public func launch(isShortSet: Bool, isEnglish: Bool, isPrivateSet: Bool, appName: ClientAppList) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        var fileContent = ""
        var previousMapCategoryLabel = ""
        
        
        // Iterating for All Maps list
        for mapClientLine in mapsClientTable {
            
            if oneMapGenerator.isItUnnecessaryMap(mapClientLine, isShortSet, isEnglish, isPrivateSet: isPrivateSet, appName) {continue}
            
            if !isAllMapsInOneFile {
                fileContent = ""
            }
        
        
            let mapNameLabel = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let mapCategoryLabel = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            
            
            // For web pages only: split maps list for groups
            if isAllMapsInOneFile {
                
                fileContent += oneMapGenerator.getMapCategoryLabelContent(mapCategoryLabel, previousMapCategoryLabel, mapClientLine.groupPrefix, isEnglish, appName)
                
                previousMapCategoryLabel = mapCategoryLabel
            }
            
            fileContent += oneMapGenerator.getOneMapContent(appName, mapNameLabel, mapCategoryLabel, isShortSet, isEnglish, mapClientLine, mapsClientTable, mapsServerTable, previousMapCategoryLabel)
            
            
            
            // If creating new file with single map
            if !isAllMapsInOneFile {
                
                let patches = patchGenerator.getOneMapFileSavingPatches(appName, mapNameLabel, mapCategoryLabel, isShortSet, isEnglish, mapClientLine, mapsClientTable, mapsServerTable)
                
                // Save sinlge map file to GitHub syncing folder
                diskHandler.createFile(patch: patches.patch, content: fileContent, isWithBOM: false)
                
                // Save dublicate file to Heroku Server folder to use with Downloader script
                if patches.secondPatch != nil && !isShortSet {
                    diskHandler.createFile(patch: patches.secondPatch!, content: fileContent, isWithBOM: false)
                }
            }
        }
        
        
        
        // If creating one file with all maps, fit collected content to file structure
        if isAllMapsInOneFile {
            
            fileContent = oneMapGenerator.addIntroAndOutroTo(content: fileContent, isEnglish: isEnglish, appName: appName)
            
            let patches = patchGenerator.getAllMapsFileSavingPatch(isShortSet: isShortSet, isEnglish: isEnglish, appName: appName)
            
            diskHandler.createFile(patch: patches.patch, content: fileContent, isWithBOM: false)
            
            if patches.secondPatch != nil {
                diskHandler.createFile(patch: patches.secondPatch!, content: fileContent, isWithBOM: false)
            }
        }
        
        
        // Archive result to zip files
        if !isAllMapsInOneFile {
            zipHandler.zipMapsFolder(sourceShort: patchGenerator.shortPatch,
                                 SouceFull: patchGenerator.fullPatch,
                                 zipPath: patchGenerator.zipPatch,
                                 isShortSet: isShortSet,
                                 isEnglish: isEnglish,
                                 isForFolders: false)
        }
        
    }
    
}
