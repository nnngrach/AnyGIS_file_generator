//
//  GuruOneMapGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class GuruOneMapGenerator: AbstractOneMapGenerator {
    
    private let guruTemplates = GuruTemplates()
    
    
    override var layersGenerator: AbstractMapLayersGenerator {
        return GuruMapLayersGenerator()
    }
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        
        let fullName = getFullName(clientLine, isEnglish)
        
        var content = guruTemplates.getFileIntro(mapName: fullName, comment: clientLine.comment)
        
        content += layersGenerator.getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
        
        content += guruTemplates.getFileOutro()
        
        return content
    }
    
    
    
    
    private func getFullName(_ clientLine: MapsClientData, _ isEnglish: Bool) -> String {
        
        if isEnglish {
            return clientLine.groupNameEng + " - " + clientLine.shortNameEng
        } else {
            return clientLine.groupName + " - " + clientLine.shortName
        }
    }
    
    
}
