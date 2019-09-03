//
//  OruxTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct OruxTemplates {
    
    private let descriptionTemplates = DecsriptionTemplate()
    
    //MARK: Templates for Orux maps XML
    
    func getFileIntro() -> String {
        return """
        <?xml version="1.0" encoding="utf-8"?>
        <onlinemapsources>
        
        \(descriptionTemplates.getDescription(appName: .Orux))
        """
    }
    
    
    func getItem(id: Int64, projectionName: String, name: String, group: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, cacheable: Int, yInvertingScript: String) -> String {
        
        
        return """
        
        <onlinemapsource uid="\(id)">
        <name>\(name) (\(group))</name>
        <url><![CDATA[\(url)]]></url>
        <servers>\(serverParts)</servers>
        <maxzoom>\(zoomMax)</maxzoom>
        <minzoom>\(zoomMin)</minzoom>
        <projection>\(projectionName)</projection>
        <downloadable>1</downloadable>
        <cacheable>\(cacheable)</cacheable>
        <xop></xop>
        <yop>\(yInvertingScript)</yop>
        <zop></zop>
        <qop></qop>
        </onlinemapsource>
        
        """
    }
    
    
    func getFileOutro() -> String {
        return """
        
        
        </onlinemapsources>
        """
    }

}
