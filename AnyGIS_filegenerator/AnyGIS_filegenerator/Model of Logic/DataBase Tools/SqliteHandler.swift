//
//  SqliteHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import SQLite



class SqliteHandler {
    
    private let patchTemplates = FilePatchTemplates.init()
    
    
    
    public func getMapProcessingData() throws -> [MapProcessingData] {
        
        var result: [MapProcessingData] = []
        
        let connection = try Connection(patchTemplates.dataBasePatch, readonly: true)
        
        let rawTable = try connection.prepare(MapProcessingDataDB.table)
        
        
        
        for rawLine in rawTable {

            let item = MapProcessingData(name: rawLine[MapProcessingDataDB.name]!,
                      mode: rawLine[MapProcessingDataDB.mode]!,
                      backgroundUrl: rawLine[MapProcessingDataDB.backgroundUrl]!,
                      backgroundServerName: rawLine[MapProcessingDataDB.backgroundServerName]!,
                      referer: rawLine[MapProcessingDataDB.referer]!,
                      zoomMin: rawLine[MapProcessingDataDB.zoomMin]!,
                      zoomMax: rawLine[MapProcessingDataDB.zoomMax]!
            )
            
            result.append(item)
        }
        
        return result
    }
    
    
    
    
    
    public func getMapClientFilesData() throws -> [MapClientFilesData] {
        
        var result: [MapClientFilesData] = []
        
        let connection = try Connection(patchTemplates.dataBasePatch, readonly: true)
        
        let rawTable = try connection.prepare(MapClientFilesDataDB.table)
        
        
        for rawLine in rawTable {
            
            let item = MapClientFilesData(id: rawLine[MapClientFilesDataDB.id]!,
                          anygisMapName: rawLine[MapClientFilesDataDB.anygisMapName]!,
                          order: rawLine[MapClientFilesDataDB.order]!,
                          isInStarterSet: rawLine[MapClientFilesDataDB.isInStarterSet]!,
                          groupName: rawLine[MapClientFilesDataDB.groupName]!,
                          groupNameEng: rawLine[MapClientFilesDataDB.groupNameEng]!,
                          shortName: rawLine[MapClientFilesDataDB.shortName]!,
                          shortNameEng: rawLine[MapClientFilesDataDB.shortNameEng]!,
                          groupPrefix: rawLine[MapClientFilesDataDB.groupPrefix]!,
                          oruxGroupPrefix: rawLine[MapClientFilesDataDB.oruxGroupPrefix]!,
                          clientMapName: rawLine[MapClientFilesDataDB.clientMapName]!,
                          projection: rawLine[MapClientFilesDataDB.projection]!,
                          layersIDList: rawLine[MapClientFilesDataDB.layersIDList]!,
                          visible: rawLine[MapClientFilesDataDB.visible]!,
                          countries: rawLine[MapClientFilesDataDB.countries]!,
                          usage: rawLine[MapClientFilesDataDB.usage]!,
                          forLocus: rawLine[MapClientFilesDataDB.forLocus]!,
                          forGuru: rawLine[MapClientFilesDataDB.forGuru]!,
                          forOrux: rawLine[MapClientFilesDataDB.forOrux]!,
                          forOsmand: rawLine[MapClientFilesDataDB.forOsmand]!,
                          locusLoadAnygis: rawLine[MapClientFilesDataDB.locusLoadAnygis]!,
                          gurumapsLoadAnygis: rawLine[MapClientFilesDataDB.gurumapsLoadAnygis]!,
                          oruxLoadAnygis: rawLine[MapClientFilesDataDB.oruxLoadAnygis]!,
                          osmandLoadAnygis: rawLine[MapClientFilesDataDB.osmandLoadAnygis]!,
                          cacheStoringHours: rawLine[MapClientFilesDataDB.cacheStoringHours]!,
                          comment: rawLine[MapClientFilesDataDB.comment]!)
            
            
            result.append(item)
        }
        
        return result
    }
    
    
    
}
