//
//  OruxTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import Foundation

struct OruxTemplates {
    
    
    //MARK: Templates for Orux maps XML
    
    func getOruxMapIntro() -> String {
        return """
        <?xml version="1.0" encoding="utf-8"?>
        <onlinemapsources>
        
        """
    }
    
    
    func getOruxMapsItem(id: Int, projectionName: String, name: String, group: String, url: String, serverParts: String, zoomMin: Int, zoomMax: Int, cacheable: Int, yInvertingScript: String) -> String {
        
        
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
    
    
    func getOutroMapOutro() -> String {
        return """
        
        
        </onlinemapsources>
        """
    }

}
