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
    
    
    
    
    
    public func getMapsClientData(isEnglish: Bool) throws -> [MapsClientData] {
        
        var result: [MapsClientData] = []
        
        let connection = try Connection(patchTemplates.dataBasePatch, readonly: true)
        
        //let rawTable = try connection.prepare(MapClientFilesDataDB.table)
        
        let firstSortingField = isEnglish ? MapsClientDataDB.orderEng : MapsClientDataDB.order
        let secondSortingField = isEnglish ? MapsClientDataDB.shortNameEng : MapsClientDataDB.shortName
        
        let rawTable = try connection
            .prepare(MapsClientDataDB.table
            .order(firstSortingField, secondSortingField))
        
        
        for rawLine in rawTable {
            
            if (isEnglish && !rawLine[MapsClientDataDB.forEng]!) { continue }
            if (!isEnglish && !rawLine[MapsClientDataDB.forRus]!) { continue }
            
            let item = MapsClientData(id: rawLine[MapsClientDataDB.id]!,
                          anygisMapName: rawLine[MapsClientDataDB.anygisMapName]!,
                          order: rawLine[MapsClientDataDB.order]!,
                          orderEng: rawLine[MapsClientDataDB.orderEng]!,
                          isInStarterSet: rawLine[MapsClientDataDB.isInStarterSet]!,
                          isInStarterSetEng: rawLine[MapsClientDataDB.isInStarterSetEng]!,
                          forRus: rawLine[MapsClientDataDB.forRus]!,
                          forEng: rawLine[MapsClientDataDB.forEng]!,
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
                          forOsmandMeta: rawLine[MapsClientDataDB.forOsmandMeta]!,
                          forAlpine: rawLine[MapsClientDataDB.forAlpine]!,
                          locusLoadAnygis: rawLine[MapsClientDataDB.locusLoadAnygis]!,
                          gurumapsLoadAnygis: rawLine[MapsClientDataDB.gurumapsLoadAnygis]!,
                          oruxLoadAnygis: rawLine[MapsClientDataDB.oruxLoadAnygis]!,
                          osmandLoadAnygis: rawLine[MapsClientDataDB.osmandLoadAnygis]!,
                          osmandMetaLoadAnygis: rawLine[MapsClientDataDB.osmandMetaLoadAnygis]!,
                          alpineLoadAnygis: rawLine[MapsClientDataDB.alpineLoadAnygis]!,
                          cacheStoringHours: rawLine[MapsClientDataDB.cacheStoringHours]!,
                          isRetina: rawLine[MapsClientDataDB.isRetina]!,
                          comment: rawLine[MapsClientDataDB.comment]!,
                          copyright: rawLine[MapsClientDataDB.copyright]!)
            
            
            result.append(item)
        }
        
        return result
    }
    
    
    
    
    public func getMapsPreviewData() throws -> [MapsPreviewData] {
        
        var result: [MapsPreviewData] = []
        
        let connection = try Connection(patchTemplates.dataBasePatch, readonly: true)
        
        let rawTable = try connection
            .prepare(MapsPreviewDataDB.table
                .order(MapsPreviewDataDB.name))
        
        
        for rawLine in rawTable {
            
            let item = MapsPreviewData(name: rawLine[MapsPreviewDataDB.name]!,
                                    isTesting: rawLine[MapsPreviewDataDB.isTesting]!,
                                    hasPrewiew: rawLine[MapsPreviewDataDB.hasPrewiew]!,
                                    isOverlay: rawLine[MapsPreviewDataDB.isOverlay]!,
                                    previewLat: rawLine[MapsPreviewDataDB.previewLat]!,
                                    previewLon: rawLine[MapsPreviewDataDB.previewLon]!,
                                    previewZoom: rawLine[MapsPreviewDataDB.previewZoom]!,
                                    previewUrl: rawLine[MapsPreviewDataDB.previewUrl]!,
                                    isGlobal: rawLine[MapsPreviewDataDB.isGlobal]!,
                                    bboxL: rawLine[MapsPreviewDataDB.bboxL]!,
                                    bboxT: rawLine[MapsPreviewDataDB.bboxT]!,
                                    bboxR: rawLine[MapsPreviewDataDB.bboxR]!,
                                    bboxB: rawLine[MapsPreviewDataDB.bboxB]!)
        
            result.append(item)
        }
        
        return result
    }
    
    
    public func getMapsPreviewBy(name: String) -> MapsPreviewData? {
        
        do {
            let connection = try Connection(patchTemplates.dataBasePatch, readonly: true)
            
            let rawLine = try connection
                .pluck(MapsPreviewDataDB.table
                    .filter(MapsPreviewDataDB.name == name)
            )
            
            guard rawLine != nil else {return nil}
            
            return MapsPreviewData(name: rawLine![MapsPreviewDataDB.name]!,
                                   isTesting: rawLine![MapsPreviewDataDB.isTesting]!,
                                   hasPrewiew: rawLine![MapsPreviewDataDB.hasPrewiew]!,
                                   isOverlay: rawLine![MapsPreviewDataDB.isOverlay]!,
                                   previewLat: rawLine![MapsPreviewDataDB.previewLat]!,
                                   previewLon: rawLine![MapsPreviewDataDB.previewLon]!,
                                   previewZoom: rawLine![MapsPreviewDataDB.previewZoom]!,
                                   previewUrl: rawLine![MapsPreviewDataDB.previewUrl]!,
                                   isGlobal: rawLine![MapsPreviewDataDB.isGlobal]!,
                                   bboxL: rawLine![MapsPreviewDataDB.bboxL]!,
                                   bboxT: rawLine![MapsPreviewDataDB.bboxT]!,
                                   bboxR: rawLine![MapsPreviewDataDB.bboxR]!,
                                   bboxB: rawLine![MapsPreviewDataDB.bboxB]!)
            
        } catch {
            return nil
        }
    }
    
}
