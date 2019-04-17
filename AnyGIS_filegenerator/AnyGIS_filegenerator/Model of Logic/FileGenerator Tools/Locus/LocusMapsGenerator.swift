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
    
    
    override var isAllMapsInOneFile: Bool {
        return false
    }
    
    
    override var serverNamesSeparator: String {
        return ";"
    }
    
    
    
    override var urlPartsForReplacement: [(old: String, new: String)] {
        return [(old: "{invY}", new: "{y}"),
                (old: "https", new: "http")]
    }
    
    
    
    override func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String) -> String {
        
        
        var content = locusTemplates.getMapFileIntro(comment: clientLine.comment)
        
        content += getAllLayersContent(mapName, mapCategory, clientLine.id, clientLine.layersIDList, clientLine, clientTable, serverTable, isEnglish, appName, previousCategory)
        
        content += locusTemplates.getMapFileOutro()
        
        
        return content
    }
    
    
    
    override func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData]) -> (patch: String, secondPatch: String?) {
        
        // File patch generating
        let patches = generateOneMapFileSavingPatches(
            shortPatch: patchTemplates.localPathToLocusMapsShort,
            fullPatch: patchTemplates.localPathToLocusMapsFull,
            serverFolder: "",
            extention: ".xml",
            clientLine: clientLine,
            isShortSet: isShortSet,
            isEnglish: isEnglish)
        
        return (patch: patches.gitHub, secondPatch: nil)
    }
    
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData) -> String {
        
        return locusTemplates.getMapFileItem(id: clientLine.id, projection: clientLine.projection, visible: clientLine.visible, background: background, group: mapCategory, name: mapName, countries: clientLine.countries, usage: clientLine.usage, url: url, serverParts: serverParts, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, referer: serverLine.referer)
    }
    
}
