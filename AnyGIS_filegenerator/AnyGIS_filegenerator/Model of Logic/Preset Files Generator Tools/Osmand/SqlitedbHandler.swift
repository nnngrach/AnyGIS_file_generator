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
    

    
    public func createFile(dto: OsmandGeneratorDTO) throws {
        
        var folderPatch = ""
        
        if dto.isPrivateSet {
            folderPatch = patchTemplates.localPathToOsmandMapsPrivate
        } else {
            if dto.isShortSet {
                folderPatch = patchTemplates.localPathToOsmandMapsShort
            } else {
                folderPatch = patchTemplates.localPathToOsmandMapsFull
            }
        }
        
        
         let langLabel = dto.isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        let filePatch = folderPatch + langLabel + "=" + dto.filename + ".sqlitedb"
        
        // sqlitedb uses iverted zoom
        let sqlitedbMinZoom = String(17 - dto.zoommax)
        let sqlitedbMaxZoom = String(17 - dto.zoommin)
        
        let isInvertedY: Int64 = dto.isInvertedY ? 1 : 0
        let isEllipsoid: Int64 = dto.isEllipsoid ? 1 : 0
        
        let referer = dto.refererUrl ?? ""
        
        let db = try Connection(filePatch)
        
        try createTilesTable(db)
        try createMetadataTable(db)
        try createInfoTable(zoommin: sqlitedbMinZoom, zoommax: sqlitedbMaxZoom, patch: dto.url, serverNames: dto.serverNames, isEllipsoid: isEllipsoid, isYInverted: isInvertedY, tileSize: dto.tileSize, refererUrl: referer, timeSupport: dto.timeSupport, timeStoring: dto.timeStoring, defaultTileSize: dto.defaultTileSize, db)
    }
    
    

    
    fileprivate func createInfoTable(zoommin: String, zoommax: String, patch: String, serverNames: String, isEllipsoid: Int64, isYInverted: Int64, tileSize: String, refererUrl: String?, timeSupport: String, timeStoring: String, defaultTileSize: String, _ db: Connection) throws {
        
        let urlWithDefaultTileSize = patch.replacingOccurrences(of: "{tileSize}", with: defaultTileSize)
        
        let info = Table("info")

        let minzoom = Expression<String?>("minzoom")
        let maxzoom = Expression<String?>("maxzoom")
        let url = Expression<String?>("url")
        let randoms = Expression<String?>("randoms")
        let referer = Expression<String?>("referer")
        let ellipsoid = Expression<Int64?>("ellipsoid")
        let invertedY = Expression<Int64?>("inverted_y")
        let sizeOfTile = Expression<String?>("tilesize")
        let timeSupported = Expression<String?>("timeSupported")
        let expireminutes = Expression<String?>("expireminutes")
        let timecolumn = Expression<String?>("timecolumn")
        let tilenumbering = Expression<String?>("tilenumbering")


        try db.run(info.create { t in
            t.column(minzoom)
            t.column(maxzoom)
            t.column(url)
            t.column(randoms)
            t.column(referer)
            t.column(ellipsoid)
            t.column(invertedY)
            t.column(sizeOfTile)
            t.column(timeSupported)
            t.column(timecolumn)
            t.column(expireminutes)
            t.column(tilenumbering)
        })

        try db.run(info.insert(minzoom <- zoommin,
                                maxzoom <- zoommax,
                                url <- urlWithDefaultTileSize,
                                randoms <- serverNames,
                                referer <- refererUrl,
                                ellipsoid <- isEllipsoid,
                                invertedY <- isYInverted,
                                sizeOfTile <- tileSize,
                                timeSupported <- timeSupport,
                                timecolumn <- timeSupport,
                                expireminutes <- timeStoring,
                                tilenumbering <- "BigPlanet"
        ))
        
//        try db.execute("""
//                   BEGIN TRANSACTION;
//                   CREATE TABLE info (minzoom INTEGER, maxzoom INTEGER, ellipsoid TEXT, invertedY TEXT, "url" TEXT, "randoms" TEXT, "referer" TEXT, "timeSupported" TEXT, timecolumn TEXT, expireminutes TEXT, tilenumbering TEXT);
//                   PRAGMA foreign_keys=OFF;
//                   INSERT INTO info VALUES(\(zoommin),\(zoommax),'\(isEllipsoid)', '\(isYInverted)', '\(urlWithDefaultTileSize)','\(serverNames)', '\(refererUrl ?? "")', '\(timeSupport)', '\(timeSupport)','\(timeStoring)', 'BigPlanet');
//                   COMMIT;
//                   """
//               )
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
        
//        try db.execute("""
//            BEGIN TRANSACTION;
//            CREATE TABLE IF NOT EXISTS "tiles" (x int, y int, z int, s int, image blob, time int, PRIMARY KEY (x,y,z,s));
//            CREATE INDEX "index_tiles_on_x" ON "tiles" ("x");
//            CREATE INDEX "index_tiles_on_y" ON "tiles" ("y");
//            CREATE INDEX "index_tiles_on_z" ON "tiles" ("z");
//            COMMIT TRANSACTION;
//            """
//        )
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
