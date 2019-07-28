//
//  AlpineMapsTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/07/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct AlpineMapsTemplates {
    
    private let patchTemplates = FilePatchTemplates()
    private let webPagesTemplates = WebPageTemplates()
    private let descriptionTemplates = DecsriptionTemplate()
    
    
    //MARK: Templates for Locus maps XML
    
    
    func getMapFileItem(id: Int64, projection: Int64, visible: Bool, background: String, group: String, name: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String, isRetina: Bool) -> String {
        
        
        let result = """
        <?xml version="1.0" encoding="utf-8" ?>
        <aqx version="6">
        
        <name>\(group)</name>
        <description>\(group)</description>
        
            \(getId(id: id, group: group))
                <name>\(name)</name>
                <copyright>\(name)</copyright>
                <data-source></data-source>
                \(getRegion(countries))
                \(getUsageType(usage))
                <preview-location>5.90,44.80,10</preview-location>
        
                <level>
                    \(getProections(projection))
                    <zoom-values>\(getZoomLevels(min: zoomMin, max: zoomMax))</zoom-values>
        
                    <servers>
                        \(getReferer(referer))
                        \(getURL(url, serverParts))
                    </servers>
                </level>
            </source>
        </aqx>
        """
        
        return result
    }
    
    
    
    
    
    
    func getId(id: Int64, group: String) -> String {
        if group == "Overlay" {
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
        //return "<user-agent>{$application-agent}</user-agent>"
        return "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36"
    }
    
    
    
    func getURL(_ url: String, _ serverParts: String) -> String {
        var result = ""
        
        if serverParts.replacingOccurrences(of: " ", with: "") == "" {
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
    

    
}

