//
//  SqlitedbHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

class SqlitedbHandler {
    
    private let patchTemplates = FilePatchTemplates.init()
    

    
    public func createFile(isShortSet: Bool, filename: String, zoommin: Int64, zoommax: Int64, patch: String, projection: Int64, method: String?, refererUrl: String?, timeSupport: String, timeStoring: String, isEnglish: Bool) throws {
        
        let folderPatch = isShortSet ? patchTemplates.localPathToOsmandMapsShort : patchTemplates.localPathToOsmandMapsFull
        
         let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        let filePatch = folderPatch + langLabel + filename + ".sqlitedb"
        
        let sqlitedbMinZoom = String(17 - zoommax)
        let sqlitedbMaxZoom = String(17 - zoommin)
        
        let db = try Connection(filePatch)
        
        try createTilesTable(db)
        try createMetadataTable(db)
        try createInfoTable(zoommin: sqlitedbMinZoom, zoommax: sqlitedbMaxZoom, patch: patch, projection: projection, method: method, refererUrl: refererUrl, timeSupport: timeSupport, timeStoring: timeStoring, db)
    }
    
    
    
    
    
    fileprivate func createInfoTable(zoommin: String, zoommax: String, patch: String, projection: Int64, method: String?, refererUrl: String?, timeSupport: String, timeStoring: String, _ db: Connection) throws {
        
        let info = Table("info")
        
        let minzoom = Expression<String?>("minzoom")
        let maxzoom = Expression<String?>("maxzoom")
        let url = Expression<String?>("url")
        let ellipsoid = Expression<Int64?>("ellipsoid")
        let timeSupported = Expression<String?>("timeSupported")
        let expireminutes = Expression<String?>("expireminutes")
        let timecolumn = Expression<String?>("timecolumn")
        let tilenumbering = Expression<String?>("tilenumbering")
        let referer = Expression<String?>("referer")
        
        
        let rule = Expression<String?>("rule")
        
        try db.run(info.create { t in
            t.column(minzoom)
            t.column(maxzoom)
            t.column(url)
            t.column(ellipsoid)
            t.column(rule)
            t.column(timeSupported)
            t.column(expireminutes)
            t.column(timecolumn)
            t.column(referer)
            t.column(tilenumbering)
            
            
            
        })
        
        try db.run(info.insert(minzoom <- zoommin,
                                maxzoom <- zoommax,
                                url <- patch,
                                ellipsoid <- projection,
                                rule <- method,
                                timeSupported <- timeSupport,
                                timecolumn <- timeSupport,
                                expireminutes <- timeStoring,
                                referer <- refererUrl,
                                tilenumbering <- "BigPlanet"
        ))
    }
    
    
    
    
    
    fileprivate func createTilesTable(_ db: Connection) throws {
        
        let tiles = Table("tiles")
        
        let x = Expression<Int64>("x")
        let y = Expression<Int64>("y")
        let z = Expression<Int64>("z")
        let s = Expression<Int64?>("s")
        let image = Expression<SQLite.Blob?>("image")
        let time = Expression<Int64?>("time")
        
        try db.run(tiles.create { t in
            t.column(x)
            t.column(y)
            t.column(z)
            t.column(s)
            t.column(image)
            t.column(time)
            t.primaryKey(x, y, z)
        })
        
        try db.run(tiles.createIndex(x))
        try db.run(tiles.createIndex(y))
        try db.run(tiles.createIndex(z))
        try db.run(tiles.createIndex(s))
    }
    
    

    
    fileprivate func createMetadataTable(_ db: Connection) throws {
        
        let metadata = Table("android_metadata")
        
        let locale = Expression<String?>("locale")
        
        try db.run(metadata.create { t in
            t.column(locale)
        })
        
        try db.run(metadata.insert(or: .replace,
                                   locale <- "ru_RU"
        ))
    }
    
}
