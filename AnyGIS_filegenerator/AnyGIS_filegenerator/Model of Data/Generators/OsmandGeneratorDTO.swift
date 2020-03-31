//
//  OsmandGeneratorDTO.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 31/03/2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

struct OsmandGeneratorDTO {
    let filename: String
    let zoommin: Int64
    let zoommax: Int64
    let url: String
    let serverNames: String
    let refererUrl: String?
    let isEllipsoid: Bool
    let isInvertedY: Bool
    let tileSize: String
    let defaultTileSize: String
    let timeSupport: String
    let timeStoring: String
    let cachingMinutes: String
    let isEnglish: Bool
    let isShortSet: Bool
    let isPrivateSet: Bool
}
