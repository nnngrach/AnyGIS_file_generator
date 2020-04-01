//
//  WestraPassesGeojson.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//


import Foundation

struct GeoJsonFeatureCollection: Codable {
    var type: String
    var features: [GeoJsonFeature]
}

