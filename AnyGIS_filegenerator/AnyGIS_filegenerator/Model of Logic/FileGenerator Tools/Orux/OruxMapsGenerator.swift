//
//  OruxChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 15/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OruxMapsGenerator: AbstractGenerator {
    
    private let oruxTemplates = OruxTemplates()
    
    
    override var isAllMapsInOneFile: Bool {
        return true
    }
    
    
    override var serverPartsSeparator: String {
        return ","
    }
    
    
    
    override var replacingUrlParts: [(old: String, new: String)] {
        return [(old: "{x}", new: "{$x}"),
                (old: "{y}", new: "{$y}"),
                (old: "{z}", new: "{$z}"),
                (old: "{s}", new: "{$s}"),
                (old: "{invY}", new: "{$y}"),
                (old: "{$quad}", new: "{$q}")]
    }
    
    
    
    override func addIntroAndOutroTo(content: String, isEnglish: Bool, appName: ClientAppList) -> String {
        return oruxTemplates.getFileIntro() + content + oruxTemplates.getFileOutro()
    }
    
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        return getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientTable, serverTable, isEnglish, appName, previousCategory)
    }
    
    
    
    
    override func generateOneLayerContent(id: Int64, projection: Int64, visible: Bool, background: String, group: String, groupPrefix: String, name: String, nameEng: String, clientMapName: String,  countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String, cacheStoringHours: Int64, oruxCategory: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let cacheable = cacheStoringHours == 0 ? 0 : 1
        
        var yInvertingScript = ""
        var currentProjection = ""
        
        switch projection {
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
        
        
        return oruxTemplates.getItem(id: id, projectionName: currentProjection, name: name, group: oruxCategory, url: url, serverParts: serverParts, zoomMin: zoomMin, zoomMax: zoomMax, cacheable: cacheable, yInvertingScript: yInvertingScript)
    }
    
    
    
    
    override func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let patch = isShortSet ? patchTemplates.localPathToOruxMapsShortInServer : patchTemplates.localPathToOruxMapsFullInServer
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        return patch + langLabel + "onlinemapsources.xml"
    }
    
}
