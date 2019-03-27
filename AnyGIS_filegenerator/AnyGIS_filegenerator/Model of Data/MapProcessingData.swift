//
//  MapList.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import SQLite

struct MapProcessingData {
    
    let name: String
    let mode: String
    let backgroundUrl: String
    let backgroundServerName: String
    let referer: String
    let zoomMin: Int64
    let zoomMax: Int64
    
}