//
//  DesktopMapsTemplate.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/01/2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

class DesktopMapsTemplate {
    
    
    public func getFileContent(mapName: String, anygisMapName: String, isProxyOnly: Bool, url: String, serverParts: String, dpiSdName: String, dpiHdName: String, referer: String, minZoom: Int64, maxZoom: Int64, proection: Int64, anygisHostUrl: String) -> String {
        
        return getIntro(mapName: mapName, anygisMapName: anygisMapName, anygisHostUrl: anygisHostUrl) + getUrl(isProxyOnly: isProxyOnly, urlTemplate: url, dpiSdName: dpiSdName, dpiHdName: dpiHdName) + getServerNames(isProxyOnly: isProxyOnly, serverParts) + getZoom(minZoom: minZoom, maxZoom: maxZoom) + getReferer(referer) + getProectionDescription(proection)
        

    }
    
    
    
    private func getIntro(mapName: String, anygisMapName: String, anygisHostUrl: String) -> String {
        return """
        [Name]
        \(mapName)
        
        [URL via AnyGIS proxy]
        \(anygisHostUrl + anygisMapName)/{x}/{y}/{z}
        """
    }
    
    
    
    private func getUrl(isProxyOnly: Bool, urlTemplate: String, dpiSdName: String, dpiHdName: String) -> String {
        
        if isProxyOnly {
            return ""
            
        } else if dpiHdName.replacingOccurrences(of: " ", with: "") == "" {
            return """
            
            
            [URL direct]
            \(urlTemplate)
            """
            
        } else {
            
            let urlSD = urlTemplate.replacingOccurrences(of: "{tileSize}", with: dpiSdName)
            let urlHD = urlTemplate.replacingOccurrences(of: "{tileSize}", with: dpiHdName)
            
            return """
            
            
            [URL direct 256px]
            \(urlSD)
            
            [URL direct 512px]
            \(urlHD)
            """
        }
        
    }
    
    
    
    private func getServerNames(isProxyOnly: Bool, _ serverParts: String) -> String {
        
        if isProxyOnly {
            return ""
            
        } else if serverParts.replacingOccurrences(of: " ", with: "") == "" {
            return ""
            
        } else if serverParts.count > 16 {
            return ""
            
        } else if serverParts.contains("sasPlanet"){
            return ""
            
        } else if serverParts == "wikimapia" {
            return """
            
            
            [Server parts]
            (x%4) + (y%4)*4
            """
            
        } else {
            return """
            
            
            [Server parts]
            \(serverParts)
            """
        }
    }
    
    
    
    private func getReferer(_ referer: String) -> String {
        
        if referer.replacingOccurrences(of: " ", with: "") == "" {
            return ""
            
        } else if referer.contains("anygis"){
            return ""
            
        } else {
            return """
            
            
            [HTTP Referer]
            \(referer)
            """
        }
    }
    
    
    
    private func getZoom(minZoom: Int64, maxZoom: Int64) -> String {
        return """
        
        
        [Min Zoom level]
        \(minZoom)
        
        [Max Zoom level]
        \(maxZoom)
        """
    }
    
    
    
    private func getProectionDescription(_ locusProectionNumber: Int64) -> String {
        if locusProectionNumber == 1 {
            return """
            
            
            [Proection description]
            With inverted Y
            """
            
        } else if locusProectionNumber == 2 {
            return """
            
            
            [Proection description]
            Ellipsoid
            """
            
        } else {
            return ""
        }
    }
    
}
