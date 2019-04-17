//
//  WebPagesOneMapGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class WebPagesOneMapGenerator: AbstractOneMapGenerator {
    
    private let webTemplates = WebPageTemplates()
    
    
    override var layersGenerator: AbstractMapLayersGenerator {
        return WebPagesLayersGenerator()
    }
    
    
    
    override func addIntroAndOutroTo(content: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let intro = webTemplates.getMarkdownHeader(isEnglish: isEnglish) + webTemplates.getMarkdownMaplistIntro(appName: appName, isEnglish: isEnglish)
        
        return intro + content
    }
    
    
    
    override func generateContentCategoryLabel(_ appName: ClientAppList, _ categoryName: String, _ fileName: String, _ isEnglish: Bool) -> String {
        
        return webTemplates.getMarkdownMaplistCategory(appName: appName, categoryName: categoryName, fileGroupPrefix: fileName, isEnglish: isEnglish)
    }
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        return layersGenerator.getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
    }
    
}
