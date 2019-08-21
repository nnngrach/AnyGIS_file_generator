//
//  SavingPatchGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class AbstractSavingPatchGenerator {
    
    public let patchTemplates = FilePatchTemplates()
    
    public var shortPatch: String {
        return ""
    }
    
    public var fullPatch: String {
        return ""
    }
    
    public var zipPatch: String {
        return ""
    }
    
    
    public func getAllMapsFileSavingPatch(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) -> String {
        return ""
    }
    
    
    
    public func getOneMapFileSavingPatches(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData])  -> (patch: String, secondPatch: String?)  {
        
        return (patch: "", secondPatch: nil)
    }
    
    
    
    public func generateOneMapFileSavingPatches(shortPatch: String, fullPatch: String, serverFolder: String?, extention: String, clientLine: MapsClientData, isShortSet: Bool, isEnglish: Bool) -> (gitHub: String, server: String?) {
        
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
