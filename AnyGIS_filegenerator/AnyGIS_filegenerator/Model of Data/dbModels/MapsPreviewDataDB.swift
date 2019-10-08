//
//  MapsPreviewDataDB.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/09/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

struct MapsPreviewDataDB {
    
    static let table = Table("CoordinateMapList")
    
    static let name = Expression<String?>("name")
    static let isTesting = Expression<Bool?>("isTesting")
    static let hasPrewiew = Expression<Bool?>("hasPrewiew")
    
    static let isOverlay = Expression<Bool?>("isOverlay")
    
    static let previewLat = Expression<Double?>("previewLat")
    static let previewLon = Expression<Double?>("previewLon")
    static let previewZoom = Expression<Int64?>("previewZoom")
    static let previewUrl = Expression<String?>("previewUrl")

    static let isGlobal = Expression<Bool?>("isGlobal")
    static let bboxL = Expression<Double?>("bboxL")
    static let bboxT = Expression<Double?>("bboxT")
    static let bboxR = Expression<Double?>("bboxR")
    static let bboxB = Expression<Double?>("bboxB")
}
