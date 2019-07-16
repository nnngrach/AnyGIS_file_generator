//
//  DecsriptionTemplate.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct DecsriptionTemplate {
    
    private let webPagesTemplates = WebPageTemplates()
    
    
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
        case .OsmandMetainfo:
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
}
