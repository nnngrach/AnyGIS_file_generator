//
//  SasPlanetTemplate.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/10/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class SasPlanetTemplate {
    
    private let webTemplates = WebPageTemplates()
    
    
    func getParamContent(_ mapClientLine: MapsClientData, _ mapServerLine: MapsServerData, _ sasPlanetLine: SasPlanetData, _ mapPreviewLine: MapsPreviewData) -> String {
        
        let text = """
        [PARAMS]
        \r\n
        GUID=\(getId(mapClientLine.id))
        \r\n
        ParentSubMenu_ru=\(sasPlanetLine.menuRu)
        \r\n
        ParentSubMenu_uk=\(sasPlanetLine.menuUk)
        \r\n
        ParentSubMenu=\(sasPlanetLine.menuEn)
        \r\n
        name_ru=\(sasPlanetLine.nameRu)
        \r\n
        name_uk=\(sasPlanetLine.nameUk)
        \r\n
        name=\(sasPlanetLine.nameEn)
        \r\n
        NameInCache=\(sasPlanetLine.mapFileName)
        \r\n
        asLayer=\(getLayerNumber(mapPreviewLine.isOverlay))
        \r\n
        \(getProjection(mapClientLine.projection))
        \r\n
        DefURLBase=\(getURL(mapServerLine.backgroundUrl, mapServerLine.backgroundServerName, mapClientLine.sasLoadAnygis, anygisMapname: mapServerLine.name))
        \r\n
        RequestHead=Referer: \(getReferer(mapServerLine.referer))\\r\\nConnection: keep-alive\\r\\nUser-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36\\r\\nAccept: image/webp,image/apng,image/*,*/*;q=0.8\\r\\nAccept-Encoding: gzip, deflate\\r\\nAccept-Language: ru,en-US;q=0.9,en;q=0.8
        \r\n
        ContentType=image/jpeg,image/png
        \r\n
        Ext=.\(sasPlanetLine.tileFormat)
        \r\n
        \(getLicense(mapClientLine.copyright))
        """
        
        return text
    }
    
    
    
    private func getId(_ locusID: Int64) -> String {
        
        let locusIdString = String(locusID)
        
        let template = "5522dd55-55dd-dd55-d55d-555555555555"
        let templateArray = Array(template)
        
        var notСhangeableGUID = ""
        let prefixLenght = template.count - locusIdString.count
        
        for i in 0 ..< prefixLenght {
            notСhangeableGUID.append(templateArray[i])
        }
        
        notСhangeableGUID.append(locusIdString)
        
        return "{" + notСhangeableGUID + "}"
    }
    
    
    
    
    private func getURL(_ url: String, _ serverParts: String, _ isUsingAnygis: Bool, anygisMapname: String) -> String {
        
        if isUsingAnygis {
            
            return webTemplates.anygisMapUrl.replacingOccurrences(of: "{mapName}", with: anygisMapname)
            
        } else {
            
            if serverParts.count > 1 {
                let newServerParts = getServerParts(serverParts)
                return url.replacingOccurrences(of: "{s}", with: newServerParts)
                
            } else {
                return url
            }
        }
    }
    
    
    
    private func getServerParts(_ serverParts: String) -> String {
        let correctedServerParts = serverParts.replacingOccurrences(of: ";", with: ",")
        return "{s:" + correctedServerParts + "}"
    }
    
    
    
    private func getProjection(_ locusProjection: Int64) -> String {
        
        if locusProjection == 2 {
            return """
            projection=2
            \r\n
            sradiusa=6378137
            \r\n
            sradiusb=6356752
            """
        } else {
            return """
            projection=1
            \r\n
            sradiusa=6378137
            \r\n
            sradiusb=6378137
            """
        }
    }
    
    
    private func getLayerNumber(_ isOverlay: Bool) -> String{
        
        return isOverlay ? "1" : "0"
    }
    
    
    private func getLicense(_ copyright: String) -> String {
        if copyright.replacingOccurrences(of: " ", with: "") == "" {
            return ""
        } else {
            return "License= " + copyright
        }
    }
    
    
    // ??? Maybe let it be empty ???
    private func getReferer(_ referer: String) -> String {
        if referer.count > 1 {
            return referer
        } else {
            return "https://anygis.ru"
        }
    }
    
//    private func getHeaders(_ referer: String) -> String {
//        if referer.replacingOccurrences(of: " ", with: "") == "" {
//            return ""
//        } else {
//            let separator = "\r\n"
//
//            return "RequestHead=Referer: " + referer + separator + "User-Agent: " + USER_AGENT
//        }
//    }
    
    
    
//    func getScriptContent(_ url: String, serverPart: String) -> String {
//
//        var variablesPart = ""
//        var scriptBeginning = ""
//        var finalUrl = ""
//
//
//
//
//        if variablesPart.count != 0 {
//            variablesPart = "var\n" + variablesPart
//        }
//
//        return """
//        \(variablesPart)
//        """
//    }
}



