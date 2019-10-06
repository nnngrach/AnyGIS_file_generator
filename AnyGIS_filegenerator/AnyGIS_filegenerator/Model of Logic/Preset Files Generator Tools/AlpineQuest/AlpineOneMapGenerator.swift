
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AlpineOneMapGenerator: AbstractOneMapGenerator {
    
    private let alpineTemplates = AlpineMapsTemplates()
    
    
    override var layersGenerator: AbstractMapLayersGenerator {
        return AlpineMapLayersGenerator()
    }
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        //var content = layersGenerator.getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
        //return content
        
        let groupName = isEnglish ? clientLine.groupNameEng : clientLine.groupName
        
        let intro = alpineTemplates.getIntro(groupName: groupName)
        
        let oneMapData = layersGenerator.getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
        
        let outro = alpineTemplates.getOutro()
        
        return intro + oneMapData + outro
    }
    
}
