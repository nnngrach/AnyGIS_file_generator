//
//  OruxMapLayersGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OruxMapLayersGenerator: AbstractMapLayersGenerator {
    
    private let oruxTemplates = OruxTemplates()
    
    
    override var serverNamesSeparator: String {
        return ","
    }
    
    
    override var urlPartsForReplacement: [(old: String, new: String)] {
        return [(old: "{x}", new: "{$x}"),
                (old: "{y}", new: "{$y}"),
                (old: "{z}", new: "{$z}"),
                (old: "{s}", new: "{$s}"),
                (old: "{invY}", new: "{$y}"),
                (old: "{$quad}", new: "{$q}")]
    }
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isRetina: Bool, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData, _ mainLayerId: Int64) -> String {
        
        let cacheable = clientLine.cacheStoringHours == 0 ? 0 : 1
        
        var yInvertingScript = ""
        var currentProjection = ""
        
        switch clientLine.projection {
        case 0, 5:
            currentProjection = "MERCATORESFERICA"
        case 1:
            currentProjection = "MERCATORESFERICA"
            yInvertingScript = "0"
        case 2:
            currentProjection = "MERCATORELIPSOIDAL"
        default:
            fatalError("Wrong proection in ORUX generateLayersContent()")
        }
        
        let urlWithDefaultTileSize = url.replacingOccurrences(of: "{ts}", with: serverLine.dpiSD)
        
        
        return oruxTemplates.getItem(id: clientLine.id, projectionName: currentProjection, name: mapName, group: clientLine.oruxGroupPrefix, url: urlWithDefaultTileSize, serverParts: serverParts, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, cacheable: cacheable, yInvertingScript: yInvertingScript)
    }
    
}
