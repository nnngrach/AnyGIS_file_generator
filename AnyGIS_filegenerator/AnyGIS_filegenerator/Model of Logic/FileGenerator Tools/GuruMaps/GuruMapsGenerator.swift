//
//  GuruChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 14/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class GuruMapsGenerator: AbstractGenerator {
    
    private let guruTemplates = GuruTemplates()
    
    
    override var serverPartsSeparator: String {
        return " "
    }
    
    
    override var replacingUrlParts: [(old: String, new: String)] {
        return [(old: "{x}", new: "{$x}"),
                (old: "{y}", new: "{$y}"),
                (old: "{z}", new: "{$z}"),
                (old: "{s}", new: "{$serverpart}"),
                (old: "{invY}", new: "{$invY}"),
                (old: "&", new: "{&amp;}")]
    }
    
    
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> String {
        
        
        var content = guruTemplates.getFileIntro(mapName: mapName, comment: clientLine.comment)
        
        content += getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientTable, serverTable, appName)
        
        content += guruTemplates.getFileOutro()
        
        
        return content
    }
    
    
    
    
    override func getPatchesForMapSaving(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {

        // File patch generating
        let patches = getSavingFilePatches(
            shortPatch: patchTemplates.localPathToGuruMapsShort,
            fullPatch: patchTemplates.localPathToGuruMapsFull,
            serverFolder: patchTemplates.localPathToGuruMapsInServer,
            extention: ".ms",
            clientLine: clientLine,
            isShortSet: isShortSet,
            isEnglish: isEnglish)
        
        return (patch: patches.gitHub, secondPatch: patches.server)
    }
    
    
    
    
    override func generateOneLayerContent(id: Int64, projection: Int64, visible: Bool, background: String, group: String, name: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String) -> String {
        
        return guruTemplates.getItem(url: url, zoomMin: zoomMin, zoomMax: zoomMax, serverParts: serverParts)
    }
    
    
    
}
