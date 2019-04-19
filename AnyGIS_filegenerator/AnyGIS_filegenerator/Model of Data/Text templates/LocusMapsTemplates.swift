//
//  LocusMapstemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct LocusMapsTemplates {
    
    private let patchTemplates = FilePatchTemplates()
    private let webPagesTemplates = WebPageTemplates()
    private let descriptionTemplates = DecsriptionTemplate()
    
    
    //MARK: Templates for Locus maps XML
    
    func getMapFileIntro(comment: String) -> String {
        
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
        
        \(descriptionTemplates.getDescription(appName: .Locus))
        
        \(secondDescription)
        
        <providers>
        
        """
    }
    
    
    
    
    func getMapFileItem(id: Int64, projection: Int64, visible: Bool, background: String, group: String, name: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String, tileSize: String) -> String {
        
        var result = """
        
        <provider id="\(id)" type="\(projection)" visible="\(visible)" background="\(background)">
        <name>\(group)</name>
        <mode>\(name)</mode>
        <countries>\(countries)</countries>
        <usage>\(usage)</usage>
        <url><![CDATA[\(url)]]></url>
        
        """
        
        
        if serverParts != "" || serverParts != " " {
            result += """
            <serverPart>\(serverParts)</serverPart>
            
            """
        }
        
        
        result += """
        <zoomPart>{z}-8</zoomPart>
        <zoomMin>\(zoomMin + 8)</zoomMin>    <!-- \(zoomMin) -->
        <zoomMax>\(zoomMax + 8)</zoomMax>   <!-- \(zoomMax) -->
        <tileSize>256</tileSize>
        
        """
        
        
        if referer.replacingOccurrences(of: " ", with: "") != "" {
            result += """
            <extraHeader><![CDATA[Referer#\(referer)]]></extraHeader>
            
            """
        }
        
        
        result += """
        <extraHeader><![CDATA[User-Agent#Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36]]></extraHeader>
        <attribution><![CDATA[Сборник карт AnyGIS. <a href="\(webPagesTemplates.locusPage)">Проверить обновления</a>]]></attribution>
        </provider>
        
        """
        
        return result
    }
    
    
    
    
    func getMapFileOutro() -> String {
        return """
        
        </providers>
        """
    }
    
    
}
