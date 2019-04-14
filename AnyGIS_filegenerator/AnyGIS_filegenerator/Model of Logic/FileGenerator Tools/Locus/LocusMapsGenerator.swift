//
//  LocusChild.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 14/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusMapsGenerator: AbstractGenerator {
    
    private let locusTemplates = LocusMapsTemplates()
    
    
    
    override var serverPartsSeparator: String {
        return ";"
    }
    
    
    
    override var replacingUrlParts: [(old: String, new: String)] {
        return [(old: "{invY}", new: "{y}"),
                (old: "https", new: "http")]
    }
    
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> String {
        
        
        var content = locusTemplates.getMapFileIntro(comment: clientLine.comment)
        
        content += getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientTable, serverTable, appName)
        
        content += locusTemplates.getMapFileOutro()
        
        
        return content
    }
    
    
    
    override func getPatchesForMapSaving(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {
        
        // File patch generating
        let patches = getSavingFilePatches(
            shortPatch: patchTemplates.localPathToLocusMapsShort,
            fullPatch: patchTemplates.localPathToLocusMapsFull,
            serverFolder: "",
            extention: ".xml",
            clientLine: clientLine,
            isShortSet: isShortSet,
            isEnglish: isEnglish)
        
        return (patch: patches.gitHub, secondPatch: nil)
    }
    
    
    
    override func generateOneLayerContent(id: Int64, projection: Int64, visible: Bool, background: String, group: String, name: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String) -> String {
        
        return locusTemplates.getMapFileItem(id: id, projection: projection, visible: visible, background: background, group: group, name: name, countries: countries, usage: usage, url: url, serverParts: serverParts, zoomMin: zoomMin, zoomMax: zoomMax, referer: referer)
    }
    
}
