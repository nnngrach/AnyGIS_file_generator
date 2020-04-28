//
//  WesraPassNakarte.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct WestraPassNakarte: Codable {
    var id: String?
    var name: String?
    var altnames:String?
    var latlon: [Double]
    var elevation: String?
    var grade_eng: String?
    var grade: String?
    var is_summit: Int?
    var connects: String?
    var slopes: String?
    var author: String?
    var comments: [WestraPassNakarteComments]?
}

struct WestraPassNakarteComments: Codable {
    var content: String?
    var user: String?
}
