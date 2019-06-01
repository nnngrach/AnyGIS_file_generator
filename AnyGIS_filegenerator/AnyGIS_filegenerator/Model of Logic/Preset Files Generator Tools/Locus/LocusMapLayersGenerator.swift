//
//  LocusOneMapGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusMapLayersGenerator: AbstractMapLayersGenerator {
    
    private let locusTemplates = LocusMapsTemplates()
    
    
    override var serverNamesSeparator: String {
        return ";"
    }
    
    
    override var urlPartsForReplacement: [(old: String, new: String)] {
        return [(old: "{invY}", new: "{y}"),
                (old: "https", new: "http")]
    }
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isRetina: Bool, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        return locusTemplates.getMapFileItem(id: clientLine.id, projection: clientLine.projection, visible: clientLine.visible, background: background, group: mapCategory, name: mapName, countries: clientLine.countries, usage: clientLine.usage, url: url, serverParts: serverParts, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, referer: serverLine.referer, isRetina: isRetina)
    }
    
}
