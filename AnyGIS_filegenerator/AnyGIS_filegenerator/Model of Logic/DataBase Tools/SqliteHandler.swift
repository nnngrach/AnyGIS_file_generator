//
//  SqliteHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite



class SqliteHandler {
    
    private let patchTemplates = FilePatchTemplates.init()
    
    
    
    public func getMapsServerData() throws -> [MapsServerData] {
        
        var result: [MapsServerData] = []
        
        let connection = try Connection(patchTemplates.dataBasePatch, readonly: true)
        
        //let rawTable = try connection.prepare(MapProcessingDataDB.table)
        
        let rawTable = try connection
            .prepare(MapsServerDataDB.table
                .order(MapsServerDataDB.name))
        
        
        for rawLine in rawTable {

            let item = MapsServerData(name: rawLine[MapsServerDataDB.name]!,
                      mode: rawLine[MapsServerDataDB.mode]!,
                      backgroundUrl: rawLine[MapsServerDataDB.backgroundUrl]!,
                      backgroundServerName: rawLine[MapsServerDataDB.backgroundServerName]!,
                      referer: rawLine[MapsServerDataDB.referer]!,
                      zoomMin: rawLine[MapsServerDataDB.zoomMin]!,
                      zoomMax: rawLine[MapsServerDataDB.zoomMax]!
            )
            
            result.append(item)
        }
        
        return result
    }
    
    
    
    
    
    public func getMapsClientData() throws -> [MapsClientData] {
        
        var result: [MapsClientData] = []
        
        let connection = try Connection(patchTemplates.dataBasePatch, readonly: true)
        
        //let rawTable = try connection.prepare(MapClientFilesDataDB.table)
        
        let rawTable = try connection
            .prepare(MapsClientDataDB.table
            .order(MapsClientDataDB.order, MapsClientDataDB.shortName))
        
        
        for rawLine in rawTable {
            
            let item = MapsClientData(id: rawLine[MapsClientDataDB.id]!,
                          anygisMapName: rawLine[MapsClientDataDB.anygisMapName]!,
                          order: rawLine[MapsClientDataDB.order]!,
                          isInStarterSet: rawLine[MapsClientDataDB.isInStarterSet]!,
                          groupName: rawLine[MapsClientDataDB.groupName]!,
                          groupNameEng: rawLine[MapsClientDataDB.groupNameEng]!,
                          shortName: rawLine[MapsClientDataDB.shortName]!,
                          shortNameEng: rawLine[MapsClientDataDB.shortNameEng]!,
                          groupPrefix: rawLine[MapsClientDataDB.groupPrefix]!,
                          oruxGroupPrefix: rawLine[MapsClientDataDB.oruxGroupPrefix]!,
                          clientMapName: rawLine[MapsClientDataDB.clientMapName]!,
                          projection: rawLine[MapsClientDataDB.projection]!,
                          layersIDList: rawLine[MapsClientDataDB.layersIDList]!,
                          visible: rawLine[MapsClientDataDB.visible]!,
                          countries: rawLine[MapsClientDataDB.countries]!,
                          usage: rawLine[MapsClientDataDB.usage]!,
                          forLocus: rawLine[MapsClientDataDB.forLocus]!,
                          forGuru: rawLine[MapsClientDataDB.forGuru]!,
                          forOrux: rawLine[MapsClientDataDB.forOrux]!,
                          forOsmand: rawLine[MapsClientDataDB.forOsmand]!,
                          locusLoadAnygis: rawLine[MapsClientDataDB.locusLoadAnygis]!,
                          gurumapsLoadAnygis: rawLine[MapsClientDataDB.gurumapsLoadAnygis]!,
                          oruxLoadAnygis: rawLine[MapsClientDataDB.oruxLoadAnygis]!,
                          osmandLoadAnygis: rawLine[MapsClientDataDB.osmandLoadAnygis]!,
                          cacheStoringHours: rawLine[MapsClientDataDB.cacheStoringHours]!,
                          comment: rawLine[MapsClientDataDB.comment]!)
            
            
            result.append(item)
        }
        
        return result
    }
    
    
    
}
