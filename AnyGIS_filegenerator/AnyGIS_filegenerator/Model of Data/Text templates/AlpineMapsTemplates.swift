//
//  AlpineMapsTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct AlpineMapsTemplates {
    
    private let patchTemplates = FilePathTemplates()
    private let webPagesTemplates = WebPageTemplates()
    private let descriptionTemplates = DecsriptionTemplate()
    
    
    //MARK: Templates for Locus maps XML
    
    
    func getMapFileItem(id: Int64, projection: Int64, visible: Bool, background: String, group: String, name: String, copyright: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String, isRetina: Bool, isGlobal: Bool, previewPoint: (lat: Double, lon: Double, z: Int64), bbox: (left: Double, top: Double, right: Double, bottom: Double), storeDays: Int) -> String {
        
        
        let intro = getIntro(groupName: group)
        
        let oneMapData = getOneMapData(id: id, projection: projection, visible: visible, background: background, group: group, name: name, copyright: copyright, countries: countries, usage: usage, url: url, serverParts: serverParts, zoomMin: zoomMin, zoomMax: zoomMax, referer: referer, isRetina: isRetina, isGlobal: isGlobal, previewPoint: previewPoint, bbox: bbox, storeDays: storeDays)
        
        let outro = getOutro()
        
        return intro + oneMapData + outro
    }
    
    
    
    func getIntro(groupName: String) -> String {
        return """
        <?xml version="1.0" encoding="utf-8" ?>
        <aqx version="9">
        
        \(descriptionTemplates.getDescription(appName: .Alpine))
        
        <name>\(groupName)</name>
        <description></description>
        
        """
    }
    
    func getOneMapData(id: Int64, projection: Int64, visible: Bool, background: String, group: String, name: String, copyright: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String, isRetina: Bool, isGlobal: Bool, previewPoint: (lat: Double, lon: Double, z: Int64), bbox: (left: Double, top: Double, right: Double, bottom: Double), storeDays: Int) -> String {
        
        return """

            \(getId(id: id, group: group))
                <name>\(name)</name>
                \(getCopyright(copyright))
                <data-source></data-source>
                \(getRegion(countries))
                \(getUsageType(usage))
        
                <preview-location>\(previewPoint.lon),\(previewPoint.lat),\(previewPoint.z)</preview-location>
                \(getBbox(isGlobal: isGlobal, bbox: bbox))
        
                <level>
                    <zoom-values>\(getZoomLevels(min: zoomMin, max: zoomMax))</zoom-values>
                    \(getProections(projection))
                    <update-delay>\(storeDays)D</update-delay>
        
                    <servers>
                        \(getReferer(referer))
                        \(getURL(url, serverParts))
                    </servers>
                </level>
            </source>
        
        
        """
    }
    
    func getOutro() -> String {
        return """
        
        </aqx>
        """
    }
    
    
    
    
    
    func getId(id: Int64, group: String) -> String {
        if group.hasPrefix("Overlay") {
            return "<source id=\"\(id)\" layer=\"true\">"
        } else {
            return "<source id=\"\(id)\">"
        }
    }
    
    
    
    func getRegion(_ region: String) -> String {
        if region == "World" {
            return "<region>WRLD</region>"
        } else {
            return "<region>OTHE</region>"
        }
    }
    
    
    
    func getUsageType(_ usage: String) -> String {
        switch usage {
        case "aero":
            return "<type>AERO</type>"
        case "city":
            return "<type>ROAD</type>"
        case "hiking":
            return "<type>TOPO</type>"
        case "road":
            return "<type>ROAD</type>"
        case "cycle":
            return "<type>TOPO</type>"
        case "nautical":
            return "<type>NAUT</type>"
        case "overlay":
            return "<type>OTHE</type>"
        case "photo":
            return "<type>SATE</type>"
        case "ski":
            return "<type>TOPO</type>"
        default:
            return "<type>OTHE</type>"
        }
    }
    
    
    
    func getZoomLevels(min: Int64, max: Int64) -> String {
        
        var result = ""
        
        for i in (min...max) {
            result += "\(i),"
        }
        
        result = String(result.dropLast())
        return result
    }
    
    
    
    func getReferer(_ referer: String) -> String {
        var result = ""
        if referer.replacingOccurrences(of: " ", with: "") != "" {
            result = "<referer><![CDATA[\(referer)]]></referer>"
        }
        return result
    }
    
    
    
    func getUserAgent() -> String {
        return USER_AGENT
    }
    
    
    
    func getURL(_ url: String, _ serverParts: String) -> String {
        
        
        
        var result = ""
        
        if serverParts.replacingOccurrences(of: " ", with: "") == "" {
            result = "<server><![CDATA[\(url)]]></server>"
            
        } else if url.hasPrefix(patchTemplates.serverHostHttp){
            result = "<server><![CDATA[\(url)]]></server>"
            
        } else {
            let serverNames = serverParts.components(separatedBy: ";")
            result += "\n"
            for serverName in serverNames {
                let currentUrl = url.replacingOccurrences(of: "{s}", with: serverName)
                result += """
                                <server><![CDATA[\(currentUrl)]]></server>
                
                """
            }
        }
        
        return result
    }
    
    
    
    func getProections(_ projection: Int64) -> String {
        var result = ""
        
        if projection == 1 {
            result = "<expression set=\"invY\" type=\"int\">0-y</expression>"
            
        } else if projection == 2 {
            result = """
            
                        <projection-name>mercator</projection-name>
                        <projection-geoid>wgs 84</projection-geoid>
            """
        }
        return result
    }
    
    
    
    func getBbox(isGlobal: Bool, bbox: (left: Double, top: Double, right: Double, bottom: Double)) -> String {
        
        let isBboxPositive = (bbox.left >= 0) && (bbox.top >= 0) && (bbox.right >= 0) && (bbox.bottom >= 0)
        
        
        if isGlobal {
            return ""
            
        } else if !isBboxPositive {
            return ""
            
        } else {
            return "<outline>\(bbox.left),\(bbox.top) \(bbox.right),\(bbox.top) \(bbox.right),\(bbox.bottom) \(bbox.left),\(bbox.bottom)</outline>"
        }
    }
    
    
    func getCopyright(_ copyright: String) -> String {
        
        if copyright.replacingOccurrences(of: " ", with: "") == "" {
            return ""
        } else {
            let timmedCopyright = copyright.replacingOccurrences(of: "© ", with: "")
            return "<copyright>\(timmedCopyright)</copyright>"
        }
    }
}

