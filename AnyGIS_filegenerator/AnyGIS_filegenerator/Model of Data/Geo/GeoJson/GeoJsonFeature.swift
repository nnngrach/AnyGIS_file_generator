//
//  WestraPassGeoJson.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//


import Foundation

struct GeoJsonFeature: Codable {
    var type: String
    var geometry: GeoJsonPointGeometry
    var properties: [String : String]
}

