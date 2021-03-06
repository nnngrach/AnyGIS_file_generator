//
//  WholeFileGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AbstractOneMapGenerator {
    
    public var layersGenerator: AbstractMapLayersGenerator {
        return AbstractMapLayersGenerator()
    }
    
    
    public func isItUnnecessaryMap(_ mapClientLine: MapsClientData, _ isShortSet: Bool, _ isEnglish: Bool, _ isPrivateSet: Bool, _ isAllMapsInOneFile: Bool, _ appName: ClientAppList) -> Bool {
        
        // Filter off service layers
        if appName == ClientAppList.Orux && !mapClientLine.forOrux {return true}
        if appName == ClientAppList.Locus && !mapClientLine.forLocus {return true}
        if appName == ClientAppList.Osmand && !mapClientLine.forOsmand {return true}
        if appName == ClientAppList.OsmandMetainfo && !mapClientLine.forOsmandMeta {return true}
        if appName == ClientAppList.Alpine && !mapClientLine.forAlpine {return true}
        if (appName == ClientAppList.GuruMapsIOS || appName == ClientAppList.GuruMapsAndroid) && !mapClientLine.forGuru {return true}
        if appName == ClientAppList.Desktop && !mapClientLine.forDesktop {return true}
        
        // Filter for short list
        if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {return true}
        if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {return true}
        
        // Filter for language specific maps
        if !mapClientLine.forEng && isEnglish {return true}
        if !mapClientLine.forRus && !isEnglish {return true}
        
        // Filter hidden maps
        if !mapClientLine.visible {return true}
        
        // TODO: Filter private maps
        // Filter private maps
        if !isAllMapsInOneFile {
            if !isPrivateSet && mapClientLine.isPrivate {return true}
            if isPrivateSet && !mapClientLine.isPrivate {return true}
        } else {
            if !isPrivateSet && mapClientLine.isPrivate {return true}
        }
        
        
        return false
    }
    
    
    
    
    public func addIntroAndOutroTo(content: String, isEnglish: Bool, appName: ClientAppList) -> String {
        return ""
    }
    
    
    
    
    public func getMapCategoryLabelContent(_ currentCategory: String, _ previousCategory: String, _ groupPrefix: String, _ isEnglish: Bool, _ appName: ClientAppList) -> String {
        
        if currentCategory != previousCategory {
            return generateContentCategoryLabel(appName, currentCategory, groupPrefix, isEnglish)
        } else {
            return ""
        }
    }
    
    
    
    public func generateContentCategoryLabel(_ appName: ClientAppList, _ categoryName: String, _ fileGroupPrefix: String, _ isEnglish: Bool) -> String {
        
        return ""
    }
    
    
    
    public func getOneMapContent(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData], _ previousCategory: String)  -> String  {
        
        return ""
    }
    

}

