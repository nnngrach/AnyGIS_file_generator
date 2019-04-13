//
//  AbstractGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 13/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AbstractGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let patchTemplates = FilePatchTemplates()
    
    
    public func create(isShortSet: Bool,
                    isEnglish: Bool,
                    closure: (MapsClientData, [MapsClientData], [MapsServerData]) -> (patch: String, secondPatch: String?, content: String)) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forGuru else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            if !mapClientLine.forRus && !isEnglish {continue}
            if !mapClientLine.forEng && isEnglish {continue}
            
            
            
            // Get file content and file patch from closure
            let result = closure(mapClientLine, mapsClientTable, mapsServerTable)
            
            // Save file to GitHub syncing folder
            diskHandler.createFile(patch: result.patch, content: result.content)
            
            // Copy dublicate file to Public folder to use with Downloader script
            if let serverPatch = result.secondPatch  {
                if !isShortSet {
                    diskHandler.createFile(patch: serverPatch, content: result.content)
                }
            }
            
        }
    }
    
    
    
    public func generatePatches(shortPatch: String, fullPatch: String, serverFolder: String?, extention: String, clientLine: MapsClientData, isShortSet: Bool, isEnglish: Bool) -> (gitHub: String, server: String?) {
        
        let githubSyncFolder = isShortSet ? shortPatch : fullPatch
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        let filename = clientLine.groupPrefix + "-" + clientLine.clientMapName + extention
        
        let githubPatch = githubSyncFolder + langLabel + filename
        
        
        
        var serverPatch: String?
        
        if let folder = serverFolder {
            serverPatch = folder + langLabel + filename
        }
        
        
        return (gitHub: githubPatch, server: serverPatch)
    }
    
}
