//
//  AbstractFunctions.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 16/04/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

extension AbstractGenerator {
    
    
    public func getMapsCategoryLabel(_ currentCategory: String, _ previousCategory: String, _ groupPrefix: String, _ isEnglish: Bool, _ appName: ClientAppList) -> String {
        
        if currentCategory != previousCategory {
            return generateContentCategoryLabel(appName, currentCategory, groupPrefix, isEnglish)
        } else {
            return ""
        }
    }
    
    
    
    public func getAllLayersContent(_ mapName: String, _ mapCategory: String, _ currentID: Int64, _ layersIdList: String, _ mapsClientLine: MapsClientData, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ isEnglish: Bool, _ appName: ClientAppList, _ previousCategory: String) -> String {
        
        
        var content = ""
        
        
        if layersIdList == "-1" {
            
            content += getOneLayerContent(mapName, mapCategory, locusId: currentID, background: "-1", mapsClientTable, mapsServerTable, isEnglish, appName, previousCategory)
            
        } else {
            
            let layersId = layersIdList.components(separatedBy: ";")
            
            var loadId = layersId.map {Int64($0)!}
            loadId.append(currentID)
            
            var backroundId = ["-1"]
            backroundId += layersId
            
            for i in 0 ... layersId.count {
                
                content += getOneLayerContent(mapName, mapCategory, locusId: loadId[i], background: backroundId[i], mapsClientTable, mapsServerTable, isEnglish, appName, previousCategory)
            }
        }
        
        return content
    }
    
    
    
    
    
    public func getOneLayerContent(_ mapName: String, _ mapCategory: String, locusId: Int64, background: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ isEnglish: Bool, _ appName: ClientAppList, _ previousCategory: String) -> String {
        
        
        var content = ""
        
        let mapClientLine = mapsClientTable.filter {$0.id == locusId}.first!
        
        let mapServerLine = mapsServerTable.filter {$0.name == mapClientLine.anygisMapName}.first!
        
        var isLoadAnygis = false
        
        switch appName {
        case .Locus:
            isLoadAnygis = mapClientLine.locusLoadAnygis
        case .Osmand:
            isLoadAnygis = mapClientLine.osmandLoadAnygis
        case .Orux:
            isLoadAnygis = mapClientLine.oruxLoadAnygis
        case .GuruMapsIOS, .GuruMapsAndroid:
            isLoadAnygis = mapClientLine.gurumapsLoadAnygis
        }
        
        
        // Prepare Url and server parts
        var url = isLoadAnygis ? webTemplates.anygisMapUrl : mapServerLine.backgroundUrl
        
        url = replaceUrlParts(url: url, mapName: mapServerLine.name, parameters: urlPartsForReplacement)
        
        var serverParts = ""
        
        if !isLoadAnygis {
            
            let origServerParts = mapServerLine.backgroundServerName
            
            for i in origServerParts {
                serverParts.append(i)
                serverParts.append(serverNamesSeparator)
            }
            serverParts = String(serverParts.dropLast())
        }
        
        
        content += generateOneLayerContent(mapName, mapCategory, url, serverParts, background, isEnglish, appName, mapClientLine, mapServerLine)
        
        return content
    }
    
   
    

    
    

    public func replaceUrlParts(url: String, mapName: String, parameters: [(old: String,new: String)]) -> String {
        
        var resultUrl = url
        
        for pameter in parameters {
            resultUrl = resultUrl.replacingOccurrences(of: pameter.old, with: pameter.new)
        }
        
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        
        return resultUrl
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
