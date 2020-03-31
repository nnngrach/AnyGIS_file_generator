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
                "GUID={" + UUID().uuidString + "}" + rn +
                "ParentSubMenu_ru=" + sasPlanetLine.menuRu + rn +
                "ParentSubMenu_uk=" + sasPlanetLine.menuUk + rn +
                "ParentSubMenu=" + sasPlanetLine.menuEn + rn +
                "name_ru=" + sasPlanetLine.nameRu + rn +
                "name_uk=" + sasPlanetLine.nameUk + rn +
                "name=" + sasPlanetLine.nameEn + rn +
                "NameInCache=" + sasPlanetLine.mapFileName + rn +
                "asLayer=" + getLayerNumber(mapPreviewLine.isOverlay) + rn +
                getProjection(mapClientLine.projection) + rn +
                "DefURLBase=" + getURL(mapServerLine.backgroundUrl, mapClientLine.sasLoadAnygis, anygisMapname: mapServerLine.name) + rn +
                getServerParts(mapServerLine.backgroundServerName, mapClientLine.sasLoadAnygis) +
                getAllHeaders(mapServerLine.referer) + rn +
                "ContentType=image/jpeg,image/png" + rn +
                "Ext=." + sasPlanetLine.tileFormat + rn +
                getLicense(mapClientLine.copyright) + rn
    }
    
    
    
//    private func getGUID(sasPlanetLine: SasPlanetData) -> String {
//
//        if sasPlanetLine.GUID != "" {
//            return sasPlanetLine.GUID
//        } else {
//            let generatedGUID = UUID().uuidString
//            sasPlanetLine.GUID = generatedGUID
//            var a = sasPlanetLine
//
//            return generatedGUID
//        }
//    }
    
    
    
    private func getURL(_ url: String, _ isUsingAnygisProxy: Bool, anygisMapname: String) -> String {
        
        if isUsingAnygisProxy {
            return constantUrls.anygisMapUrlsTemplate.replacingOccurrences(of: "{mapName}", with: anygisMapname)
        } else {
            return url
        }
    }
    
    
    
    
    private func getServerParts(_ serverParts: String, _ isUsingAnygisProxy: Bool) -> String {
        
        let cleanedServerParts = serverParts.replacingOccurrences(of: " ", with: "")
        
        if isUsingAnygisProxy {
            return ""
        } else if cleanedServerParts.count == 0 {
            return ""
        } else {
            let correctedServerParts = serverParts.replacingOccurrences(of: ";", with: ",")
            return "ServerNames=" + correctedServerParts + rn
        }
    }
    
    
    
    private func getProjection(_ projectionCode: Int64) -> String {
        
        let ellipsodProjectionCode: Int64 = 2
        
        if projectionCode == ellipsodProjectionCode {
            return  "EPSG=3395"
        } else {
            return  "EPSG=3785"
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
        
        let refererForFriendlyServers = "https://anygis.ru/"
        
        if referer == refererForFriendlyServers {
            return "RequestHead=Referer:http://www.sasgis.org/"
        } else {
            return "RequestHead=" + getReferer(referer) + "Connection: keep-alive\\r\\nUser-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Safari/537.36\\r\\nAccept: image/webp,image/apng,image/*,*/*;q=0.8\\r\\nAccept-Encoding: gzip, deflate\\r\\nAccept-Language: ru,en-US;q=0.9,en;q=0.8"
        }
    }
    
    
    private func getReferer(_ referer: String) -> String {
        
        if referer.count > 1 {
            return "Referer:" + referer + "\\r\\n"
        } else {
            return ""
        }
    }
    
}
