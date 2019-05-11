//
//  WesraPassNakarte.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct WestraPassNakarte: Codable {
    var name: String?
    var elevation: String?
    var latlon: [String]
    var grade_eng: String
    var grade: String?
    var is_summit: String?
}
