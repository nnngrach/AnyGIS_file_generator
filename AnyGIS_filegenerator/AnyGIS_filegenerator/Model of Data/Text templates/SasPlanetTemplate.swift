//
//  SasPlanetTemplate.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/10/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class SasPlanetTemplate {
    
    private let constantUrls = WebPageTemplates()
    private let rn = "\r\n"
    
    
    
    public func getParamsTxtContent(_ mapClientLine: MapsClientData, _ mapServerLine: MapsServerData, _ sasPlanetLine: SasPlanetData, _ mapPreviewLine: MapsPreviewData) -> String {
        
        return  rn +
                "[PARAMS]" + rn +
                "GUID=" + UUID().uuidString + rn +
                "ParentSubMenu_ru=" + sasPlanetLine.menuRu + rn +
                "ParentSubMenu_uk=" + sasPlanetLine.menuUk + rn +
                "ParentSubMenu=" + sasPlanetLine.menuEn + rn +
                "name_ru=" + sasPlanetLine.nameRu + rn +
                "name_uk=" + sasPlanetLine.nameUk + rn +
                "name=" + sasPlanetLine.nameEn + rn +
                "NameInCache=" + sasPlanetLine.mapFileName + rn +
                "asLayer=" + getLayerNumber(mapPreviewLine.isOverlay) + rn +
                getProjection(mapClientLine.projection) + rn +
                "DefURLBase=" + getURL(mapServerLine.backgroundUrl, mapServerLine.backgroundServerName, mapClientLine.sasLoadAnygis, anygisMapname: mapServerLine.name) + rn +
                getAllHeaders(mapServerLine.referer) + rn +
                "ContentType=image/jpeg,image/png" + rn +
                "Ext=." + sasPlanetLine.tileFormat + rn +
                getLicense(mapClientLine.copyright) + rn
    }
    
    
    
    
    
    private func getURL(_ url: String, _ serverParts: String, _ isUsingAnygisProxy: Bool, anygisMapname: String) -> String {
        
        if isUsingAnygisProxy {
            return constantUrls.anygisMapUrlsTemplate.replacingOccurrences(of: "{mapName}", with: anygisMapname)
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
    
    
    
    private func getProjection(_ projectionCode: Int64) -> String {
        
        let ellipsodProjectionCode: Int64 = 2
        
        if projectionCode == ellipsodProjectionCode {
            return  "projection=2" + rn +
                    "sradiusa=6378137" + rn +
                    "sradiusb=6356752"
        } else {
            return  "projection=1" + rn +
                    "sradiusa=6378137" + rn +
                    "sradiusb=6378137"
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
    
    
    
    
    private func getAllHeaders(_ referer: String) -> String {
        
        return "RequestHead=" + getReferer(referer) + "Connection: keep-alive\\r\\nUser-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36\\r\\nAccept: image/webp,image/apng,image/*,*/*;q=0.8\\r\\nAccept-Encoding: gzip, deflate\\r\\nAccept-Language: ru,en-US;q=0.9,en;q=0.8"
    }
    
    
    private func getReferer(_ referer: String) -> String {
        
        if referer.count > 1 {
            return "Referer:" + referer + rn
        } else {
            return ""
        }
    }
    
    
    
//    // Deprecated:
//    // Gettingt not cnanging ID
//
//    private func getId(_ locusID: Int64) -> String {
//
//        let locusIdString = String(locusID)
//
//        let template = "5522dd55-55dd-dd55-d55d-555555555555"
//        let templateArray = Array(template)
//
//        var notСhangeableGUID = ""
//        let prefixLenght = template.count - locusIdString.count
//
//        for i in 0 ..< prefixLenght {
//            notСhangeableGUID.append(templateArray[i])
//        }
//
//        notСhangeableGUID.append(locusIdString)
//
//        return "{" + notСhangeableGUID + "}"
//    }
    
}
