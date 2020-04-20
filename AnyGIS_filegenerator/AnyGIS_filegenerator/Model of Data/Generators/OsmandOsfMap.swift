//
//  OsmandOsfMaoJson.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 20.04.2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

struct OsmandOsfMap: Codable {
    
    var name: String
    
    var url: String
    var randoms: String
    var referer: String
    
    var minZoom: Int
    var maxZoom: Int
    
    var ellipsoid: Bool
    var inverted_y: Bool
    var inversiveZoom: Bool
    
    var timesupported: Bool
    var expire: Int
    
    var tileSize: Int
    var bitDensity: Int
    var avgSize: Int
    var ext: String
    
    var sql: Bool
}
