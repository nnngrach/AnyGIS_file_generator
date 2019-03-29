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
    
    func getFileIntro(mapName: String, comment: String) -> String {
        
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
    
    
    
    func getItem(url: String, zoomMin: Int64, zoomMax: Int64, serverParts: String) -> String {
        
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
    
    
    
    func getFileOutro() -> String {
        return """
        
        </layers>
        </customMapSource>
        """
    }
    
    
}
