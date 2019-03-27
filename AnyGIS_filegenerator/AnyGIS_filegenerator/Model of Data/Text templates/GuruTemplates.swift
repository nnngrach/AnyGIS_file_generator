//
//  GuruTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import Foundation

struct GuruTemplates {
    
    
    
    //MARK: Templates for GuruMaps (Galileo) maps MS
    
    func getGuruMapIntro(mapName: String, comment: String) -> String {
        
        var secondDescription = ""
        
        if comment.replacingOccurrences(of: " ", with: "") != "" {
            secondDescription = """
            <!--
            \(comment)
            -->
            
            """
        }
        
        
        return """
        <?xml version="1.0" encoding="utf-8"?>
        
        <customMapSource>
        <name>\(mapName)</name>
        <layers>
        
        
        """
    }
    
    
    
    func getGuruMapsItem(url: String, zoomMin: Int, zoomMax: Int, serverParts: String) -> String {
        
        let firtstPart = """
        <layer>
        <minZoom>\(zoomMin)</minZoom>
        <maxZoom>\(zoomMax)</maxZoom>
        <url>\(url)</url>
        
        """
        
        var secondPart = ""
        
        if serverParts.replacingOccurrences(of: " ", with: "") != "" {
            secondPart = """
            <serverParts>\(serverParts)</serverParts>
            
            """
        }
        
        let thirdPart = """
            </layer>


        """
        
        return firtstPart + secondPart + thirdPart
    }
    
    
    
    func getGuruMapOutro() -> String {
        return """
        
        </layers>
        </customMapSource>
        """
    }
    
    
}
