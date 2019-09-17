//
//  MapsPreviewData.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 17/09/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

struct MapsPreviewData {
    
    var name: String
    var isTesting: Bool
    var hasPrewiew: Bool
    
    var isOverlay: Bool
    
    var previewLat: Double
    var previewLon: Double
    var previewZoom: Int64
    var previewUrl: String
    
    var isGlobal: Bool
    var bboxL: Double
    var bboxT: Double
    var bboxR: Double
    var bboxB: Double
    
}
