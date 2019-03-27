//
//  MapList.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import SQLite

struct MapProcessingDataDB {
    
    static let table = Table("MapsList")
    
    static let name = Expression<String?>("name")
    static let mode = Expression<String?>("mode")
    static let backgroundUrl = Expression<String?>("backgroundUrl")
    static let backgroundServerName = Expression<String?>("backgroundServerName")
    static let referer = Expression<String?>("referer")
    static let zoomMin = Expression<Int64?>("zoomMin")
    static let zoomMax = Expression<Int64?>("zoomMax")
}