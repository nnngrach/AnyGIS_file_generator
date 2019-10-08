//
//  MapList.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

struct MapsServerData {
    
    let name: String
    let mode: String
    let backgroundUrl: String
    let backgroundServerName: String
    let referer: String
    let zoomMin: Int64
    let zoomMax: Int64
    let dpiSD: String
    let dpiHD: String
    
}
