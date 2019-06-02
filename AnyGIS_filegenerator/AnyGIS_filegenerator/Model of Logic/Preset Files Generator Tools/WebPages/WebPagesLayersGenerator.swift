//
//  WebPagesLayersGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class WebPagesLayersGenerator: AbstractMapLayersGenerator {
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isRetina: Bool, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData, _ mainLayerId: Int64) -> String {
        
        guard clientLine.groupName != "Background" else {return ""}
        
        let filename = clientLine.groupPrefix + "-" + clientLine.clientMapName
        
        let mapName = isEnglish ? clientLine.shortNameEng : clientLine.shortName
        
        return webTemplates.getMarkDownMaplistItem(appName: appName, name: mapName, fileName: filename, isEnglish: isEnglish)
    }
    
}
