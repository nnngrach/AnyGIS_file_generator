//
//  SqlitedbHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import SQLite

class SqlitedbHandler {
    
    let templates = UrlTemplates.init()
    
    
    
    func test() throws {
        
        let patch = templates.localPathToOsmandMapsFull + "filename.sqlitedb"
        
        let db = try Connection(patch)
        
        let users = Table("info")
        
        let minzoom = Expression<String?>("minzoom")
        let maxzoom = Expression<String?>("maxzoom")
        let url = Expression<String?>("url")
        let ellipsoid = Expression<Int64?>("ellipsoid")
        let tilenumbering = Expression<String?>("tilenumbering")
        let timecolumn = Expression<String?>("timecolumn")
        let expireminutes = Expression<String?>("expireminutes")
        let rule = Expression<String?>("rule")
        
        try db.run(users.create { t in
            t.column(minzoom)
            t.column(maxzoom)
            t.column(url)
            t.column(ellipsoid)
            t.column(tilenumbering)
            t.column(timecolumn)
            t.column(expireminutes)
            t.column(rule)
        })
        
        try db.run(users.insert(minzoom <- "-3",
                                maxzoom <- "16",
                                url <- "http://anygis.herokuapp.com/Osm_Cycle_Map/{1}/{2}/{0}",
                                ellipsoid <- 0,
                                tilenumbering <- "BigPlanet",
                                timecolumn <- "0",
                                expireminutes <- "0",
                                rule <- nil
        ))
        
        
        
        
        let metadata = Table("android_metadata")
        
        let locale = Expression<String?>("locale")
        
        try db.run(metadata.create { t in
            t.column(locale)
        })
        
        try db.run(metadata.insert(or: .replace,
                                locale <- "ru_RU"
        ))
        
        
        
        
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
//            t.primaryKey(s)
        })
        
        try db.run(tiles.createIndex(x))
        try db.run(tiles.createIndex(y))
        try db.run(tiles.createIndex(z))
        try db.run(tiles.createIndex(s))
        
    }
    
    
}
