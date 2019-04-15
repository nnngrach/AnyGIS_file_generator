//
//  MarkChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class MarkdownPagesGenerator: AbstractGenerator {
    
    
    //private let webTemplates = WebPageTemplates()
    
    
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
    
    
    
    
    override func generateContentCategorySeparator(_ previousCategory: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        var previousFolder = previousCategory
        
        // Add link to Catecory
        if clientLine.groupName != previousFolder {
            
            previousFolder = clientLine.groupName

            let category = isEnglish ? clientLine.groupNameEng : clientLine.groupName

            return webTemplates.getMarkdownMaplistCategory(appName: appName, categoryName: category, fileName: clientLine.groupPrefix, isEnglish: isEnglish)
            
        } else {
            
            return ""
        }
    }
    
    
    
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        let filename = clientLine.groupPrefix + "-" + clientLine.clientMapName
        
        let mapName = isEnglish ? clientLine.shortNameEng : clientLine.shortName
        
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
