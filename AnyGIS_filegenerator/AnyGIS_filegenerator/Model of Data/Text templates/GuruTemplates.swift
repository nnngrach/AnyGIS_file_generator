//
//  GuruTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct GuruTemplates {
    
    private let descriptionTemplates = DecsriptionTemplate()
    
    //MARK: Templates for GuruMaps (Galileo) maps MS
    
    func getFileIntro(mapName: String, comment: String) -> String {
        
        return """
        <?xml version="1.0" encoding="utf-8"?>
        
        \(descriptionTemplates.getDescription(appName: .GuruMapsIOS))
        
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
