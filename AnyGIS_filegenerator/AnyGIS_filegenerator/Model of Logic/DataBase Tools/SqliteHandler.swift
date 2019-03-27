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
    
    
    public func getMapList() throws {
        
        let db = try Connection(patchTemplates.dataBasePatch, readonly: true)
        
        let mapsList = MapListDB.table

        let name = MapListDB.name
        
        let mapsListData = try db.prepare(mapsList)
        
        for line in mapsListData {
            print("name: \(line[name])")
        }
 
        
    }
    
}
