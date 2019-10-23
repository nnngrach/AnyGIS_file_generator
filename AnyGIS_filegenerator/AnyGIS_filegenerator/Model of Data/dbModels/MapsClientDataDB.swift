//
//  MapList.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import SQLite

struct MapsClientDataDB {
    
    static let table = Table("FileGeneratorDB")
    
    static let id = Expression<Int64?>("id")
    static let anygisMapName = Expression<String?>("anygisMapName")
    static let orderRu = Expression<Int64?>("orderRu")
    static let orderEng = Expression<Int64?>("orderEng")
    static let isInStarterSet = Expression<Bool?>("isInStarterSet")
    static let isInStarterSetEng = Expression<Bool?>("isInStarterSetEng")
    
    static let forRus = Expression<Bool?>("forRus")
    static let forEng = Expression<Bool?>("forEng")
    
    static let groupName = Expression<String?>("groupName")
    static let groupNameEng = Expression<String?>("groupNameEng")
    static let shortName = Expression<String?>("shortName")
    static let shortNameEng = Expression<String?>("shortNameEng")
    
    static let groupPrefix = Expression<String?>("groupPrefix")
    static let oruxGroupPrefix = Expression<String?>("oruxGroupPrefix")
    static let clientMapName = Expression<String?>("clientMapName")
    
    static let projection = Expression<Int64?>("projection")
    static let layersIDList = Expression<String?>("layersIDList")
    static let visible = Expression<Bool?>("visible")
    
    static let countries = Expression<String?>("countries")
    static let usage = Expression<String?>("usage")
    
    static let forLocus = Expression<Bool?>("forLocus")
    static let forGuru = Expression<Bool?>("forGuru")
    static let forOrux = Expression<Bool?>("forOrux")
    static let forOsmand = Expression<Bool?>("forOsmand")
    static let forOsmandMeta = Expression<Bool?>("forOsmandMeta")
    static let forAlpine = Expression<Bool?>("forAlpine")
    static let forSas = Expression<Bool?>("forSas")
    
    static let locusLoadAnygis = Expression<Bool?>("locusLoadAnygis")
    static let gurumapsLoadAnygis = Expression<Bool?>("gurumapsLoadAnygis")
    static let oruxLoadAnygis = Expression<Bool?>("oruxLoadAnygis")
    static let osmandLoadAnygis = Expression<Bool?>("osmandLoadAnygis")
    static let osmandMetaLoadAnygis = Expression<Bool?>("osmandMetaLoadAnygis")
    static let alpineLoadAnygis = Expression<Bool?>("alpineLoadAnygis")
    static let sasLoadAnygis = Expression<Bool?>("sasLoadAnygis")

    static let cacheStoringHours = Expression<Int64?>("cacheStoringHours")
    static let isRetina = Expression<Bool?>("isRetina")

    static let comment = Expression<String?>("comment")
    static let copyright = Expression<String?>("copyright")
}
