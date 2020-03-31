//
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusOneMapGenerator: AbstractOneMapGenerator {
    
    private let locusTemplates = LocusMapsTemplates()
    
    
    override var layersGenerator: AbstractMapLayersGenerator {
        return LocusMapLayersGenerator()
    }
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        var content = locusTemplates.getMapFileIntro(comment: clientLine.comment)
        
        content += layersGenerator.getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
        
        content += locusTemplates.getMapFileOutro()
        
        
        return content
    }
    
}
