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

    
    public var serverPartsSeparator: String {
        return ";"
    }
    
    
    public var replacingUrlParts: [(old: String, new: String)] {
        return []
    }
    
    
    
 
    
    
    // Start all maps generating
    public func createAllMaps(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        var fileContent = ""
        var previousCategory = ""
        
        
        
        for mapClientLine in mapsClientTable {
            
            if !isAllMapsInOneFile {
                fileContent = ""
            }
            
            // Filter off service layers
            if appName == ClientAppList.Locus && !mapClientLine.forLocus {continue}
            if appName == ClientAppList.Osmand && !mapClientLine.forOsmand {continue}
            if appName == ClientAppList.Orux && !mapClientLine.forOrux {continue}
            if (appName == ClientAppList.GuruMapsIOS || appName == ClientAppList.GuruMapsAndroid) && !mapClientLine.forGuru {continue}
            
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            
            // Filter for language
            if !mapClientLine.forRus && !isEnglish {continue}
            if !mapClientLine.forEng && isEnglish {continue}
            
            
            
            let mapName = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let mapCategory = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            
            
            // Overriding part: Get file content and file patch from replacing function
            fileContent += getOneMapContent(appName, mapName, mapCategory, isShortSet, isEnglish, mapClientLine, mapsClientTable, mapsServerTable, previousCategory)
            
            
            
            if !isAllMapsInOneFile {
                
                let patches = getPatchesForMapSaving(appName, mapName, mapCategory, isShortSet, isEnglish, mapClientLine, mapsClientTable, mapsServerTable)
                
                // Save sinlge map file to GitHub syncing folder
                diskHandler.createFile(patch: patches.patch, content: fileContent)
                
                // Copy dublicate file to Heroku Public folder to use with Downloader script
                if patches.secondPatch != nil && !isShortSet {
                    diskHandler.createFile(patch: patches.secondPatch!, content: fileContent)
                }
                
            } else {
                
                // Update flag: is this map from new category?
                previousCategory = updatePreviousCategory(group: mapClientLine.groupName, previousCategory: previousCategory)
            }
            
        }
        
        
        
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
    
    
    
    
    public func getPatchesForMapSaving(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData])  -> (patch: String, secondPatch: String?)  {
        
        return (patch: "", secondPatch: nil)
    }
    
    
    
    
    public func generateContentCategorySeparator(_ previousCategory: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        return ""
    }
    
    
    public func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        return ""
    }
    
    
 
    public func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) -> String {
        return ""
    }
    
    
 
    public func addIntroAndOutroTo(content: String, isEnglish: Bool, appName: ClientAppList) -> String {
        return ""
    }
    
}
