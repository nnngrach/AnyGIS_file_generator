//
//  SasPlanetDataDB.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/10/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

struct SasPlanetDataDB {
    
    static let table = Table("SasPlanetData")
    
    static let anygisName = Expression<String?>("anygisName")
    
    static let menuRu = Expression<String?>("menuRu")
    static let menuUk = Expression<String?>("menuUk")
    static let menuEn = Expression<String?>("menuEn")
    
    static let nameRu = Expression<String?>("nameRu")
    static let nameUk = Expression<String?>("nameUk")
    static let nameEn = Expression<String?>("nameEn")
    
    static let mapFolderPath = Expression<String?>("mapFolderPath")
    static let mapFileName = Expression<String?>("mapFileName")
    static let tileFormat = Expression<String?>("tileFormat")
    
    static let icon = Expression<String?>("icon")
}
