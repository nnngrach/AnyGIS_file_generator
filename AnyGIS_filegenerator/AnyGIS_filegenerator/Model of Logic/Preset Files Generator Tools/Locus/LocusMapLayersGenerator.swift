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
                (old: "{q}", new: "{c}")]
//        return [(old: "{invY}", new: "{y}"),
//                (old: "https", new: "http")]
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
        
        
        var tileScalesBlock = ""
        
        if serverLine.backgroundUrl.contains("{ts}") {
            tileScalesBlock = """
        <tileScales>
            <tileScale dpi="0" multi="1" replace="\(serverLine.dpiSD)" />
            <tileScale dpi="320" multi="2" replace="\(serverLine.dpiHD)" />
        </tileScales>
        """
        }
        
        
        return locusTemplates.getMapFileItem(id: currentLayerUnicId, projection: clientLine.projection, visible: clientLine.visible, background: backgroundLayerUnicId, group: mapCategory, name: mapName, countries: clientLine.countries, usage: clientLine.usage, url: url, serverParts: serverParts, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, referer: serverLine.referer, isRetina: isRetina, cacheTimeout: clientLine.cacheStoringHours, tileScalesBlock: tileScalesBlock, copyright: clientLine.copyright)
    }
    
}
