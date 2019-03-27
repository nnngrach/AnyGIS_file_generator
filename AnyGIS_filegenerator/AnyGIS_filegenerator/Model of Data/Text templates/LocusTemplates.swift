//
//  LocusTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import Foundation

struct LocusTemplates {
    
    private let patchTemplates = FilePatchTemplates()
    private let webPagesTemplates = WebPageTemplates()
    
    
    
    
    
    //MARK: Templates for Locus actions XLM installer
    
    func getLocusActionsIntro() -> String {
        return """
        <?xml version="1.0" encoding="utf-8"?>
        
        \(getDescription(appName: .Locus))
        
        
        <locusActions>
        
        """
    }
    
    
    
    func getLocusActionsItem(fileName: String, isIcon: Bool) -> String {
        
        let patch = isIcon ? patchTemplates.gitLocusIconsFolder : patchTemplates.gitLocusMapsFolder
        let fileType = isIcon ? ".png" : ".xml"
        let filenameWithoutSpaces = fileName.replacingOccurrences(of: " ", with: "%20")
        
        
        return """
        
        <download>
        <source>
        <![CDATA[\(patch + filenameWithoutSpaces + fileType)]]>
        </source>
        <dest>
        <![CDATA[/mapsOnline/custom/\(fileName + fileType)]]>
        </dest>
        </download>
        
        """
    }
    
    
    
    func getLocusActionsOutro() -> String {
        return """
        
        </locusActions>
        """
    }
    
    
    
    
    
    //MARK: Templates for description
    
    func getCreationTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        return dateFormatter.string(from: currentDate)
    }
    
    
    
    func getDescription(appName: ClientAppList) -> String {
        
        var currentAppPageUrl: String
        
        switch appName {
        case .GuruMapsIOS, .GuruMapsAndroid:
            currentAppPageUrl = webPagesTemplates.guruPage
        case .Locus:
            currentAppPageUrl = webPagesTemplates.locusPage
        case .Osmand:
            currentAppPageUrl = webPagesTemplates.osmandPage
        case .Orux:
            currentAppPageUrl = webPagesTemplates.oruxPage
        }
        
        let currentAppName = appName.rawValue
        
        
        let nameString = """
        Комплект карт "AnyGIS" для навигатора \(currentAppName).
        \(currentAppPageUrl)
        """
        
        
        return """
        <!--
        \(nameString)
        
        Составитель: AnyGIS (\(webPagesTemplates.email)).
        Файл обновлен: \(getCreationTime())
        
        Сделан на основе наборов карт от:
        - SAS.planet (http://www.sasgis.org/)
        - Erelen (https://melda.ru/locus/)
        - ms.Galileo-app (https://ms.galileo-app.com/)
        - Custom-maps-sourse (https://custom-map-source.appspot.com/)
        -->
        """
    }
    
    
    
    
    
    
    
    //MARK: Templates for Locus maps XML
    
    func getLocusMapIntro(comment: String) -> String {
        
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
        
        \(getDescription(appName: .Locus))
        
        \(secondDescription)
        
        <providers>
        
        """
    }
    
    
    
    
    func getLocusMapItem(id: Int, projection: Int, visible: Bool, background: String, group: String, name: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int, zoomMax: Int, referer: String) -> String {
        
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
    
    
    
    
    func getLocusMapOutro() -> String {
        return """
        
        </providers>
        """
    }
    
    
    
    
    
}
