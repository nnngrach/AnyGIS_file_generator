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
        
            <source id="\(id)" layer="true">
                <name>\(name)</name>
                <copyright>\(name)</copyright>
                <data-source></data-source>
                <region>WRLD</region>
                <type>OTHE</type>
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

