//
//  MarkChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class MarkdownPagesGenerator: AbstractGenerator {
    
    
    
    override var isAllMapsInOneFile: Bool {
        return true
    }
    
    
    
    override func addIntroAndOutroTo(content: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let intro = webTemplates.getMarkdownHeader(isEnglish: isEnglish) + webTemplates.getMarkdownMaplistIntro(appName: appName, isEnglish: isEnglish)
        
        return intro + content
    }
    
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        return getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
    }
    
    
    
    
    override func generateContentCategoryLabel(_ appName: ClientAppList, _ categoryName: String, _ fileName: String, _ isEnglish: Bool) -> String {
        
        return webTemplates.getMarkdownMaplistCategory(appName: appName, categoryName: categoryName, fileGroupPrefix: fileName, isEnglish: isEnglish)
    }
    
    
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        guard clientLine.groupName != "Background" else {return ""}
        
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
