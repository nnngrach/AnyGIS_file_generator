//
//  AbstractGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 13/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AbstractGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    public let webTemplates = WebPageTemplates()
    public let patchTemplates = FilePatchTemplates()
    
    
    public var isAllMapsInOneFile: Bool {
        return false
    }

    
    public var serverNamesSeparator: String {
        return ";"
    }
    
    
    public var urlPartsForReplacement: [(old: String, new: String)] {
        return []
    }
    
    
    
 
    
    
    public func startAllMapsCreating(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        var fileContent = ""
        var previousMapCategoryLabel = ""
        
        
        // Interating for All Maps list
        for mapClientLine in mapsClientTable {
            
            if isItUnnecessaryMap(mapClientLine, isShortSet, isEnglish, appName) {continue}
            
            if !isAllMapsInOneFile {
                fileContent = ""
            }
        
        
            let mapNameLabel = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let mapCategoryLabel = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            
            
            // For web pages only: split maps list for groups
            if isAllMapsInOneFile {
                
                fileContent += getMapCategoryLabelContent(mapCategoryLabel, previousMapCategoryLabel, mapClientLine.groupPrefix, isEnglish, appName)
                
                previousMapCategoryLabel = mapCategoryLabel
            }
            
            
            fileContent += getOneMapContent(appName, mapNameLabel, mapCategoryLabel, isShortSet, isEnglish, mapClientLine, mapsClientTable, mapsServerTable, previousMapCategoryLabel)
            
            
            
            // If creating new file with single map
            if !isAllMapsInOneFile {
                
                let patches = getOneMapFileSavingPatches(appName, mapNameLabel, mapCategoryLabel, isShortSet, isEnglish, mapClientLine, mapsClientTable, mapsServerTable)
                
                // Save sinlge map file to GitHub syncing folder
                diskHandler.createFile(patch: patches.patch, content: fileContent)
                
                // Save dublicate file to Heroku Server folder to use with Downloader script
                if patches.secondPatch != nil && !isShortSet {
                    diskHandler.createFile(patch: patches.secondPatch!, content: fileContent)
                }
            }
        }
        
        
        
        // If creating one file with all maps, fit collected content to file structure
        if isAllMapsInOneFile {
            
            fileContent = addIntroAndOutroTo(content: fileContent, isEnglish: isEnglish, appName: appName)
            
            let patch = getAllMapsFileSavingPatch(isShortSet: isShortSet, isEnglish: isEnglish, appName: appName)
            
            diskHandler.createFile(patch: patch, content: fileContent)
        }
    }
    
    
    
    
    
    
    
    // MARK: Overriding functions
    
    public func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String)  -> String  {
        
        return ""
    }
    
    
    
    public func generateContentCategoryLabel(_ appName: ClientAppList, _ categoryName: String, _ fileGroupPrefix: String, _ isEnglish: Bool) -> String {
        
        return ""
    }
    
    
    
    public func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        return ""
    }
    
    
    
    
    public func addIntroAndOutroTo(content: String, isEnglish: Bool, appName: ClientAppList) -> String {
        return ""
    }
    
    
    
    public func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData])  -> (patch: String, secondPatch: String?)  {
        
        return (patch: "", secondPatch: nil)
    }
 
    
    
    public func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) -> String {
        return ""
    }
    
}
