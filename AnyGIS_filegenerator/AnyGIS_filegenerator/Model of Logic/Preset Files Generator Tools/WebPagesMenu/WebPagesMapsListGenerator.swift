//
//  WebPagesMapsListGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 21/03/2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

class WebPagesMapsListGenerator {
    
    private let baseHandler = SqliteHandler()
    private let diskHandler = DiskHandler()
    private let patches = FilePathTemplates()
    private let abstractOneMapGenerator = AbstractOneMapGenerator()
    
    
    
    public func launch(isEnglish: Bool, isShortSet: Bool, isPrivateSet: Bool, appName: ClientAppList) throws {
        
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        var content = ""
        
        
        for mapClientLine in mapsClientTable {
            
            //Filtering
            let isItUnnecessaryMap = abstractOneMapGenerator.isItUnnecessaryMap(mapClientLine, isShortSet, isEnglish, isPrivateSet, false, appName)
            

            if !mapClientLine.visible {continue}
            
            
            // TODO: Filter private maps
            // Filter private maps
            if isPrivateSet != mapClientLine.isPrivate {continue}
            
            
            
            let previewLine = try baseHandler
                .getMapsPreviewData()
                .filter{$0.name == mapClientLine.anygisMapName}
                .first
            
            let hasPreview = (previewLine != nil) ? previewLine!.hasPrewiew : false
            
            
            
            var appsList = ""
            if mapClientLine.forLocus {appsList += "Locus;"}
            if mapClientLine.forGuru {appsList += "GuruIOS;GuruAndroid;"}
            if mapClientLine.forAlpine {appsList += "Alpine;"}
            if mapClientLine.forDesktop {appsList += "Desktop;"}
            if mapClientLine.forOsmand {appsList += "OsmandSqlite;"}
            if mapClientLine.forOsmandMeta {appsList += "OsmandMeta;"}
            appsList = String(appsList.dropLast())
            
            
            
            let fullNameRU = mapClientLine.emojiGroupRu + " " + mapClientLine.shortName
            let fullNameEN = mapClientLine.emojiGroupEn + " " + mapClientLine.shortNameEng
            let fileName = "=" + mapClientLine.groupPrefix + "=" + mapClientLine.clientMapName
            let normallisedFileName = fileName.replacingOccurrences(of: "=", with: "%3D")
            
            content += "\n"
            
            content += """
            {"nameRU": "\(fullNameRU)", "nameEn": "\(fullNameEN)", "fileName": "\(fileName)", "normallisedFileName": "\(normallisedFileName)", "apiName": "\(mapClientLine.anygisMapName)", "hasPreview": \(hasPreview), "regions": "\(mapClientLine.countries)", "types": "\(mapClientLine.groupNameEng)", "apps": "\(appsList)", "isInShortSet": \(mapClientLine.isInStarterSet)},
"""
        }
        
        
        content = String(content.dropLast())
        
        let resultContent = "const MapsList = { \"mapsList\": [ \n" + content + "\n] }"
        
        let filePath = patches.localPathToMarkdownPages + "mapsList.js"
        diskHandler.createFile(patch: filePath, content: resultContent, isWithBOM: false)
    
    }
    
}
