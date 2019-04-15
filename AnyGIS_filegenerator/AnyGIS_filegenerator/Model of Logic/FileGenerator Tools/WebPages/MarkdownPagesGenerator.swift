//
//  MarkChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class MarkdownPagesGenerator: AbstractGenerator {
    
    
    private let webTemplates = WebPageTemplates()
    
    
    override var isAllMapsInOneFile: Bool {
        return true
    }
    
    
    
    
    
    override func addIntroAndOutroTo(content: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let intro = webTemplates.getMarkdownHeader(isEnglish: isEnglish) + webTemplates.getMarkdownMaplistIntro(appName: appName, isEnglish: isEnglish)
        
        return intro + content
    }
    
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        return getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientTable, serverTable, isEnglish, appName, previousCategory)
    }
    
    
    
    
    override func generateContentCategorySeparator(id: Int64, projection: Int64, visible: Bool, background: String, group: String, groupEng: String, groupPrefix: String, name: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String, cacheStoringHours: Int64, oruxCategory: String, previousCategory: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        var previousFolder = previousCategory
        
        // Add link to Catecory
        if group != previousFolder {
            
            previousFolder = group

            let category = isEnglish ? groupEng : group

            return webTemplates.getMarkdownMaplistCategory(appName: appName, categoryName: category, fileName: groupPrefix, isEnglish: isEnglish)
            
        } else {
            
            return ""
        }
    }
    
    
    
    
    
    override func generateOneLayerContent(id: Int64, projection: Int64, visible: Bool, background: String, group: String, groupPrefix: String, name: String, nameEng: String, clientMapName: String,  countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String, cacheStoringHours: Int64, oruxCategory: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let filename = groupPrefix + "-" + clientMapName
        
        let mapName = isEnglish ? nameEng : name
        
        return webTemplates.getMarkDownMaplistItem(appName: appName, name: mapName, fileName: filename, isEnglish: isEnglish)
    }
    
    
    
    
    override func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let firstPart = patchTemplates.localPathToMarkdownPages
        let secondPart = appName.rawValue.replacingOccurrences(of: " ", with: "_")
        let thirdPart = isShortSet ? "_Short" : "_Full"
        let lastPart = isEnglish ? "_en.md" : "_ru.md"
        
        return firstPart + secondPart + thirdPart + lastPart
    }
}
