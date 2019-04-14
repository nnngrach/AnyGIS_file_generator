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
    public let patchTemplates = FilePatchTemplates()
    
    
    // MARK: Overriding part
    
    public var serverPartsSeparator: String {
        return ";"
    }
    
    
    public var replacingUrlParts: [(old: String, new: String)] {
        return []
    }
    
    
    public func overridingCreatingFileDatails(_ appName: ClientAppList, _ mapName: String, _ mapCategory: String, _ isShortSet: Bool, _ isEnglish: Bool, _ clientLine: MapsClientData, _ clientTable: [MapsClientData], _ serverTable: [MapsServerData])  -> (patch: String, secondPatch: String?, content: String)  {
        
        return (patch: "", secondPatch: nil, content: "")
    }
    
    
    public func overridingGetLayerItem(id: Int64, projection: Int64, visible: Bool, background: String, group: String, name: String, countries: String, usage: String, url: String, serverParts: String, zoomMin: Int64, zoomMax: Int64, referer: String) -> String {
        
        return ""
    }
    
    
    
    
    
    // MARK: Constant part
    
    
    // Start map generating
    public func create(isShortSet: Bool, isEnglish: Bool, appName: ClientAppList) throws {
        
        let mapsServerTable = try baseHandler.getMapsServerData()
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            
            
            // Filter off service layers
            if appName == ClientAppList.Locus && !mapClientLine.forLocus {continue}
            if appName == ClientAppList.Osmand && !mapClientLine.forOsmand {continue}
            if appName == ClientAppList.Orux && !mapClientLine.forOrux {continue}
            if (appName == ClientAppList.GuruMapsIOS || appName == ClientAppList.GuruMapsAndroid) && !mapClientLine.forGuru {continue}
            
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            
            // Filter for language
            if !mapClientLine.forRus && !isEnglish {continue}
            if !mapClientLine.forEng && isEnglish {continue}
            
            let mapName = isEnglish ? mapClientLine.shortNameEng : mapClientLine.shortName
            let mapCategory = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            
            
            // Get file content and file patch from replacing function
            let result = overridingCreatingFileDatails(appName, mapName, mapCategory, isShortSet, isEnglish, mapClientLine, mapsClientTable, mapsServerTable)

            
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
    
    
    
    
    public func getSavingPatches(shortPatch: String, fullPatch: String, serverFolder: String?, extention: String, clientLine: MapsClientData, isShortSet: Bool, isEnglish: Bool) -> (gitHub: String, server: String?) {
        
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
    
    
    
    
    public func generateLayersContent(_ mapName: String, _ mapCategory: String, _ currentID: Int64, _ layersIdList: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ appName: ClientAppList) -> String {
        
        var content = ""
        
        if layersIdList == "-1" {
            
            content += addLayerBlock(mapName, mapCategory, locusId: currentID, background: "-1", mapsClientTable, mapsServerTable, appName)
            
        } else {
            
            let layersId = layersIdList.components(separatedBy: ";")
            
            var loadId = layersId.map {Int64($0)!}
            loadId.append(currentID)
            
            var backroundId = ["-1"]
            backroundId += layersId
            
            for i in 0 ... layersId.count {
                
                content += addLayerBlock(mapName, mapCategory, locusId: loadId[i], background: backroundId[i], mapsClientTable, mapsServerTable, appName)
            }
        }
        
        return content
    }
    
    
    
    
    
    private func addLayerBlock(_ mapName: String, _ mapCategory: String, locusId: Int64, background: String, _ mapsClientTable: [MapsClientData], _ mapsServerTable: [MapsServerData], _ appName: ClientAppList) -> String {
        
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
        
        url = replacrUrlParts(url: url, mapName: mapServerLine.name, parameters: replacingUrlParts)
        
        var serverParts = ""
        
        if !isLoadAnygis {
            
            let origServerParts = mapServerLine.backgroundServerName
            
            for i in origServerParts {
                serverParts.append(i)
                serverParts.append(serverPartsSeparator)
            }
            serverParts = String(serverParts.dropLast())
        }
        
        
        let content = overridingGetLayerItem(id: mapClientLine.id, projection: mapClientLine.projection, visible: mapClientLine.visible, background: background, group: mapCategory, name: mapName, countries: mapClientLine.countries, usage: mapClientLine.usage, url: url, serverParts: serverParts, zoomMin: mapServerLine.zoomMin, zoomMax: mapServerLine.zoomMax, referer: mapServerLine.referer)
        
        
        return content
    }
    
    
    
    
    // TODO: make private
    public func replacrUrlParts(url: String, mapName: String, parameters: [(old: String,new: String)]) -> String {
        
        var resultUrl = url
        
        for pameter in parameters {
            resultUrl = resultUrl.replacingOccurrences(of: pameter.old, with: pameter.new)
        }
        
        resultUrl = resultUrl.replacingOccurrences(of: "{mapName}", with: mapName)
        
        return resultUrl
    }
    

    
}
