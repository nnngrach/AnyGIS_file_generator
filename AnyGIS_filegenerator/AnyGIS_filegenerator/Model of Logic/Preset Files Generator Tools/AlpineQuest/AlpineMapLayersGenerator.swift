
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AlpineMapLayersGenerator: AbstractMapLayersGenerator {
    
    private let alpineTemplates = AlpineMapsTemplates()
    
    
    override var serverNamesSeparator: String {
        return ";"
    }
    
    
    override var urlPartsForReplacement: [(old: String, new: String)] {
        //return [(old: "https", new: "http")]
        return []
    }
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isRetina: Bool, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData, _ mainLayerId: Int64) -> String {
        
        // New version of Locus don't overwriting maps with the same id
        var currentLayerUnicId: Int64
        var backgroundLayerUnicId: String
        let additionalText = String(mainLayerId % 100)
        
        if clientLine.id == mainLayerId {
            currentLayerUnicId = mainLayerId
        } else {
            currentLayerUnicId = Int64(additionalText + String(clientLine.id))!
        }
        
        if background == "-1" {
            backgroundLayerUnicId = background
        } else {
            backgroundLayerUnicId = additionalText + background
        }
        
        
        return alpineTemplates.getMapFileItem(id: currentLayerUnicId, projection: clientLine.projection, visible: clientLine.visible, background: backgroundLayerUnicId, group: mapCategory, name: mapName, countries: clientLine.countries, usage: clientLine.usage, url: url, serverParts: serverParts, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, referer: serverLine.referer, isRetina: isRetina)
    }
    
}
