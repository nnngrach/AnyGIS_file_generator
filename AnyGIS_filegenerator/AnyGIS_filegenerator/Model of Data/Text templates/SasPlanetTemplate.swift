//
//  SasPlanetTemplate.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/10/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class SasPlanetTemplate {
    
    
    func getParamContent(_ url: String, _ mapClientLine: MapsClientData, _ mapServerLine: MapsServerData, _ sasPlanetLine: SasPlanetData) -> String {
        
        let text = """
        [PARAMS]
        GUID=\(getId(mapClientLine.id))
        ParentSubMenu_ru=\(sasPlanetLine.menuRu)
        ParentSubMenu_uk=\(sasPlanetLine.menuUk)
        ParentSubMenu=\(sasPlanetLine.menuEn)
        name_ru=\(sasPlanetLine.nameRu)
        name_uk=\(sasPlanetLine.nameUk)
        name=\(sasPlanetLine.nameEn)
        NameInCache=\(sasPlanetLine.mapFileName)
        projection=1
        sradiusa=6378137
        sradiusb=6378137
        Ext=.\(sasPlanetLine.tileFormat)
        defaultContentType=image/jpeg,image/png
        ContentType=image/jpeg,image/png
        DefURLBase=\(getUrlPrefix(url, mapServerLine.backgroundServerName))
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
    
    
    
    private func getUrlPrefix(_ url: String, _ serverParts: String) -> String {
        
        // Replace server part if it exist
        var processedUrl = url
        
        
        if serverParts.replacingOccurrences(of: " ", with: "") != "" {
            
            processedUrl = processedUrl.replacingOccurrences(of: "{s}", with: String(serverParts.first!))
        }
        
        // get part of url before {x}, {y}, {z}
        var urlPrefixBeforeVariables = ""
        
        for char in processedUrl {
            guard char != "{" else { break }
            urlPrefixBeforeVariables.append(char)
        }
        
        return urlPrefixBeforeVariables
    }
    
    
    
    private func getLicense(_ copyright: String) -> String {
        if copyright.replacingOccurrences(of: " ", with: "") == "" {
            return ""
        } else {
            return "License= " + copyright
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
    
    
    
    func getScriptContent(_ url: String, serverPart: String) -> String {
        
        var variablesPart = ""
        var scriptBeginning = ""
        var finalUrl = ""
        
        
        
        
        if variablesPart.count != 0 {
            variablesPart = "var\n" + variablesPart
        }
        
        return """
        \(variablesPart)
        """
    }
}



