//
//  MapList.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import SQLite

struct MapClientFilesData {
    
    let id: Int64
    let anygisMapName: String
    let order: Int64
    let isInStarterSet: Bool
    
    let groupName: String
    let groupNameEng: String
    let shortName: String
    let shortNameEng: String
    
    let groupPrefix: String
    let oruxGroupPrefix: String
    let clientMapName: String
    
    let projection: Int64
    let layersIDList: String
    let visible: Bool
    
    let countries: String
    let usage: String
    
    let forLocus: Bool
    let forGuru: Bool
    let forOrux: Bool
    let forOsmand: Bool
    
    let locusLoadAnygis: Bool
    let gurumapsLoadAnygis: Bool
    let oruxLoadAnygis: Bool
    let osmandLoadAnygis: Bool
    
    let cacheStoringHours: Int64
    
    let comment: String
}
