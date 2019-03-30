//
//  MarkdownPagesGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class MarkdownPagesGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let patchTemplates = FilePatchTemplates()
    
    
    public func createMarkdownPage(appName: ClientAppList, isShortSet: Bool, isEnglish: Bool) throws {
        
        var previousFolder = ""
        
        let firstPart = appName.rawValue.replacingOccurrences(of: " ", with: "_")
        let secondPart = isShortSet ? "_Short" : "_Full"
        let lastPart = isEnglish ? "_en.md" : "_ru.md"
        let fullFileName = firstPart + secondPart + lastPart
        
        let mapsClientTable = try baseHandler.getMapsClientData()
        
        // Add first part of content
        var content = webTemplates.getMarkdownHeader(isEnglish: isEnglish) + webTemplates.getMarkdownMaplistIntro(appName: appName, isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet {continue}
            
            // Filter off service layers
            if appName == .Orux  && !mapClientLine.forOrux {continue}
            if appName == .Locus && !mapClientLine.forLocus {continue}
            if appName == .Osmand  && !mapClientLine.forOsmand {continue}
            if (appName == .GuruMapsIOS || appName == .GuruMapsAndroid)  && !mapClientLine.forGuru {continue}
            
            
            // Add link to Catecory
            if mapClientLine.groupName != previousFolder {
                
                previousFolder = mapClientLine.groupName
                
                let category = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
               
                content += webTemplates.getMarkdownMaplistCategory(appName: appName, categoryName: category, fileName: mapClientLine.groupPrefix, isEnglish: isEnglish)
            }
            
            
            // Add link to single map
            let filename = mapClientLine.groupPrefix + "_" + mapClientLine.clientMapName
            
            let name = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            
            content += webTemplates.getMarkDownMaplistItem(appName: appName, name: name, fileName: filename, isEnglish: isEnglish)
        }
        
        // Create file
        let installerPatch = patchTemplates.localPathToMarkdownPages + fullFileName
        
        diskHandler.createFile(patch: installerPatch, content: content)
    }
    
}
