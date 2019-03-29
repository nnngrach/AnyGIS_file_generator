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
    

    
    public func createFile(isShortSet: Bool, filename: String, zoommin: String, zoommax: String, patch: String, projection: Int64) throws {
        
        let folderPatch = isShortSet ? patchTemplates.localPathToOsmandMapsShort : patchTemplates.localPathToOsmandMapsFull
        
        let filePatch = folderPatch + filename + ".sqlitedb"
        
        let db = try Connection(filePatch)
        
        try createTilesTable(db)
        try createMetadataTable(db)
        try createInfoTable(zoommin: zoommin, zoommax: zoommax, patch: patch, projection: projection, db)
    }
    
    
    
    
    
    fileprivate func createInfoTable(zoommin: String, zoommax: String, patch: String, projection: Int64, _ db: Connection) throws {
        
        let info = Table("info")
        
        let minzoom = Expression<String?>("minzoom")
        let maxzoom = Expression<String?>("maxzoom")
        let url = Expression<String?>("url")
        let ellipsoid = Expression<Int64?>("ellipsoid")
        let tilenumbering = Expression<String?>("tilenumbering")
        let timecolumn = Expression<String?>("timecolumn")
        let expireminutes = Expression<String?>("expireminutes")
        let rule = Expression<String?>("rule")
        
        try db.run(info.create { t in
            t.column(minzoom)
            t.column(maxzoom)
            t.column(url)
            t.column(ellipsoid)
            t.column(tilenumbering)
            t.column(timecolumn)
            t.column(expireminutes)
            t.column(rule)
        })
        
        try db.run(info.insert(minzoom <- zoommin,
                                maxzoom <- zoommax,
                                url <- patch,
                                ellipsoid <- projection,
                                tilenumbering <- "BigPlanet",
                                timecolumn <- "0",
                                expireminutes <- "0",
                                rule <- nil
        ))
    }
    
    
    
    
    
    fileprivate func createTilesTable(_ db: Connection) throws {
        
        let tiles = Table("tiles")
        
        let x = Expression<Int64>("x")
        let y = Expression<Int64>("y")
        let z = Expression<Int64>("z")
        let s = Expression<Int64?>("s")
        let image = Expression<SQLite.Blob?>("image")
        
        try db.run(tiles.create { t in
            t.column(x)
            t.column(y)
            t.column(z)
            t.column(s)
            t.column(image)
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
