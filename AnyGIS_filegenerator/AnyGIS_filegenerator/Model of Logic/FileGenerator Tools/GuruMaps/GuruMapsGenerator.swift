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
    
    override var isAllMapsInOneFile: Bool {
        return false
    }
    
    override var serverNamesSeparator: String {
        return " "
    }
    
    
    override var urlPartsForReplacement: [(old: String, new: String)] {
        return [(old: "{x}", new: "{$x}"),
                (old: "{y}", new: "{$y}"),
                (old: "{z}", new: "{$z}"),
                (old: "{s}", new: "{$serverpart}"),
                (old: "{invY}", new: "{$invY}"),
                (old: "&", new: "{&amp;}")]
    }
    
    
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        
        var content = guruTemplates.getFileIntro(mapName: mapName, comment: clientLine.comment)
        
        content += getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
        
        content += guruTemplates.getFileOutro()
        
        
        return content
    }
    
    
    
    
    override func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {

        // File patch generating
        let patches = generateOneMapFileSavingPatches(
            shortPatch: patchTemplates.localPathToGuruMapsShort,
            fullPatch: patchTemplates.localPathToGuruMapsFull,
            serverFolder: patchTemplates.localPathToGuruMapsInServer,
            extention: ".ms",
            clientLine: clientLine,
            isShortSet: isShortSet,
            isEnglish: isEnglish)
        
        return (patch: patches.gitHub, secondPatch: patches.server)
    }
    
    
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        return guruTemplates.getItem(url: url, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, serverParts: serverParts)
    }
    
    
    
}
