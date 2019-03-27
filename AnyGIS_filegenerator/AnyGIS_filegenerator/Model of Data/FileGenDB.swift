//
//  MapList.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import SQLite

struct FileGenDB{
    
    static let table = Table("FileGeneratorDB")
    
    static let id = Expression<Int64?>("id")
    static let anygisMapName = Expression<String?>("anygisMapName")
    static let order = Expression<Int64?>("order")
    static let isInStarterSet = Expression<Bool?>("isInStarterSet")
    
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
    static let forOsmand = Expression<String?>("forOsmand")
    
    static let locusLoadAnygis = Expression<String?>("locusLoadAnygis")
    static let gurumapsLoadAnygis = Expression<String?>("gurumapsLoadAnygis")
    static let oruxLoadAnygis = Expression<String?>("oruxLoadAnygis")
    static let osmandLoadAnygis = Expression<String?>("osmandLoadAnygis")

    static let cacheStoringHours = Expression<Int64?>("cacheStoringHours")

    static let comment = Expression<String?>("comment")
}
