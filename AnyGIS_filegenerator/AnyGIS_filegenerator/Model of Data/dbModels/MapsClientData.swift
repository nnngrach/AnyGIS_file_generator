//
//  MapList.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

struct MapsClientData {
    
    let id: Int64
    let anygisMapName: String
    let orderRu: Int64
    let orderEng: Int64
    let isInStarterSet: Bool
    let isInStarterSetEng: Bool
    
    let forRus: Bool
    let forEng: Bool
    
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
    let forOsmandMeta: Bool
    let forAlpine: Bool
    let forSas: Bool
    let forDesktop: Bool
    
    let locusLoadAnygis: Bool
    let gurumapsLoadAnygis: Bool
    let oruxLoadAnygis: Bool
    let osmandLoadAnygis: Bool
    let osmandMetaLoadAnygis: Bool
    let alpineLoadAnygis: Bool
    let sasLoadAnygis: Bool
    let desktopLoadAnygis: Bool
    
    let cacheStoringHours: Int64
    let isRetina: Bool
    
    let comment: String
    let copyright: String
    
    let isPrivate: Bool
    
    let emojiGroupRu: String
    let emojiGroupEn: String
    
    let lastUpdateTime: Int64
}
