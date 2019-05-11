//
//  OsmStruct.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 11/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct OsmNode {
    var id: String
    var lat: Double
    var lon: Double
    var tags: [String : String]
}
