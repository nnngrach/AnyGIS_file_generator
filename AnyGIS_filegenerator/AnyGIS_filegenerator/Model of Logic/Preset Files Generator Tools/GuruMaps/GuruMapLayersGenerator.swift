//
//  GuruMapLayersGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class GuruMapLayersGenerator: AbstractMapLayersGenerator {
    
    private let guruTemplates = GuruTemplates()
    
    
    override var serverNamesSeparator: String {
        return " "
    }
    
    
    override var urlPartsForReplacement: [(old: String, new: String)] {
        return [(old: "{x}", new: "{$x}"),
                (old: "{y}", new: "{$y}"),
                (old: "{z}", new: "{$z}"),
                (old: "{s}", new: "{$serverpart}"),
                (old: "{invY}", new: "{$invY}"),
                (old: "&", new: "&amp;")]
    }
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isRetina: Bool, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData, _ mainLayerId: Int64) -> String {
        
        return guruTemplates.getItem(url: url, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, serverParts: serverParts)
    }
    
}
