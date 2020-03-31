
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AlpineMapLayersGenerator: AbstractMapLayersGenerator {
    
    private let baseHandler = SqliteHandler()
    private let alpineTemplates = AlpineMapsTemplates()
    
    
    override var serverNamesSeparator: String {
        return ";"
    }
    
    
    override var urlPartsForReplacement: [(old: String, new: String)] {
        return [(old: "https", new: "http")]
        //return []
    }
    
    
    override func generateOneLayerContent(_ mapName: String, _ mapCategory: String, _ url: String, _ serverParts: String, _ background: String, _ isRetina: Bool, _ isEnglish: Bool, _ appName: ClientAppList, _ clientLine: MapsClientData, _ serverLine: MapsServerData, _ mainLayerId: Int64) -> String {
        
        
        let fullMapName = isEnglish ? (clientLine.emojiGroupEn + " " + clientLine.shortNameEng) : (clientLine.emojiGroupRu + " " + clientLine.shortName)
        
        
        // New version of Locus don't overwriting maps with the same id
        var currentLayerUnicId: Int64
        var backgroundLayerUnicId: String
        let additionalText = String(mainLayerId % 100)
        
        if clientLine.id == mainLayerId {
            currentLayerUnicId = mainLayerId
        } else {
            currentLayerUnicId = Int64(additionalText + String(clientLine.id))!
        }
        
        let storeDays = Int(clientLine.cacheStoringHours / 24)
        
        
        if background == "-1" {
            backgroundLayerUnicId = background
        } else {
            backgroundLayerUnicId = additionalText + background
        }
        
        
        do {
            let previewLine = try baseHandler
                .getMapsPreviewData()
                .filter{$0.name == serverLine.name}
                .first
            
            let previewPoint = (lat: previewLine!.previewLat, lon: previewLine!.previewLon, z: previewLine!.previewZoom)
            
            let bbox = (left: previewLine!.bboxL, top: previewLine!.bboxT, right:  previewLine!.bboxR, bottom: previewLine!.bboxB)
            
            let urlWithDefaultTileSize = url.replacingOccurrences(of: "{tileSize}", with: serverLine.dpiSD)
            
            return alpineTemplates.getOneMapData(id: currentLayerUnicId, projection: clientLine.projection, visible: clientLine.visible, background: backgroundLayerUnicId, group: mapCategory, name: fullMapName, copyright: clientLine.copyright, countries: clientLine.countries, usage: clientLine.usage, url: urlWithDefaultTileSize, serverParts: serverParts, zoomMin: serverLine.zoomMin, zoomMax: serverLine.zoomMax, referer: serverLine.referer, isRetina: isRetina, isGlobal: previewLine!.isGlobal, previewPoint: previewPoint, bbox: bbox, storeDays: storeDays)
            
        } catch {
            return ""
        }
        
    }
    
    
    func getIntro(groupName: String) -> String {
        return alpineTemplates.getIntro(groupName: groupName)
    }
    
    func getOutro() -> String {
        return alpineTemplates.getOutro()
    }
    
}
