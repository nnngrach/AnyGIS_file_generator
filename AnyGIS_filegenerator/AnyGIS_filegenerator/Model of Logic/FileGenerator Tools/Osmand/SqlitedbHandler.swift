//
//  SqlitedbHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import SQLite

class SqlitedbHandler {
    
    func test() throws {
        let db = try Connection("file://///Projects/GIS/AnyGIS_file_generator/AnyGIS_filegenerator/test.sqlitedb")
    }
    
    
}
