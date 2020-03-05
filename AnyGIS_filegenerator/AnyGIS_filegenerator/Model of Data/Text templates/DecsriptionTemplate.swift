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
        case .Alpine:
            currentAppPageUrl = webPagesTemplates.alpinePage
        case .Desktop:
            currentAppPageUrl = webPagesTemplates.desktopPage
        }
        
        //let currentAppName = appName.rawValue
        
        return ""
        
//        return """
//        <!--
//        Map pack from AnyGIS.ru
//        Updated: \(getCreationTime())
//        -->
//
//        """
    }
}
