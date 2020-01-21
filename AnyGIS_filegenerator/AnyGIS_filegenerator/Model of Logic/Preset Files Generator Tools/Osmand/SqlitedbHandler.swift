//
//  SqlitedbHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

class SqlitedbHandler {
    
    private let patchTemplates = FilePathTemplates.init()
    

    
    public func createFile(isShortSet: Bool, filename: String, zoommin: Int64, zoommax: Int64, patch: String, serverNames: String, isEllipsoid: Int64, isInvertedY: Int64, refererUrl: String?, timeSupport: String, timeStoring: String, isEnglish: Bool, defaultTileSize: String) throws {
        
        let folderPatch = isShortSet ? patchTemplates.localPathToOsmandMapsShort : patchTemplates.localPathToOsmandMapsFull
        
         let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        let filePatch = folderPatch + langLabel + filename + ".sqlitedb"
        
        //let sqlitedbMinZoom = String(17 - zoommax)
        //let sqlitedbMaxZoom = String(17 - zoommin)
        let sqlitedbMinZoom = String(zoommin)
        let sqlitedbMaxZoom = String(zoommax)
        
        let db = try Connection(filePatch)
        
        try createTilesTable(db)
        try createMetadataTable(db)
        try createInfoTable(zoommin: sqlitedbMinZoom, zoommax: sqlitedbMaxZoom, patch: patch, serverNames: serverNames, isEllipsoid: isEllipsoid, isYInverted: isInvertedY, refererUrl: refererUrl, timeSupport: timeSupport, timeStoring: timeStoring, defaultTileSize: defaultTileSize, db)
    }
    
    
    
    
    
    fileprivate func createInfoTable(zoommin: String, zoommax: String, patch: String, serverNames: String, isEllipsoid: Int64, isYInverted: Int64, refererUrl: String?, timeSupport: String, timeStoring: String, defaultTileSize: String, _ db: Connection) throws {
        
        let urlWithDefaultTileSize = patch.replacingOccurrences(of: "{tileSize}", with: defaultTileSize)
        
        let info = Table("info")
        
        let minzoom = Expression<String?>("minzoom")
        let maxzoom = Expression<String?>("maxzoom")
        let url = Expression<String?>("url")
        let randoms = Expression<String?>("randoms")
        let ellipsoid = Expression<Int64?>("ellipsoid")
        let invertedY = Expression<Int64?>("inverted_y")
        let timeSupported = Expression<String?>("timeSupported")
        let expireminutes = Expression<String?>("expireminutes")
        let timecolumn = Expression<String?>("timecolumn")
        let tilenumbering = Expression<String?>("tilenumbering")
        let referer = Expression<String?>("referer")
        
        
        try db.run(info.create { t in
            t.column(minzoom)
            t.column(maxzoom)
            t.column(url)
            t.column(randoms)
            t.column(ellipsoid)
            t.column(invertedY)
            t.column(referer)
            t.column(timeSupported)
            t.column(timecolumn)
            t.column(expireminutes)
            t.column(tilenumbering)
        })
        
        try db.run(info.insert(minzoom <- zoommin,
                                maxzoom <- zoommax,
                                url <- urlWithDefaultTileSize,
                                randoms <- serverNames,
                                ellipsoid <- isEllipsoid,
                                invertedY <- isYInverted,
                                referer <- refererUrl,
                                timeSupported <- timeSupport,
                                timecolumn <- timeSupport,
                                expireminutes <- timeStoring,
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
