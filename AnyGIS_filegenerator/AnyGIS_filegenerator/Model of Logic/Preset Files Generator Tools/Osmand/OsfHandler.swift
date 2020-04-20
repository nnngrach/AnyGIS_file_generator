//
//  OsfHandler.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 20.04.2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

class OsfHandler {
    
    private let diskHandler = DiskHandler()
    private let patchTemplates = FilePathTemplates()
    
    
    private var allMapsObjects: [OsmandOsfMap] = []
    
    public func reset() {
        allMapsObjects = []
    }
    
    
    public func addMap(dto: OsmandGeneratorDTO) throws {
        
        let currentMap = OsmandOsfMap(
            name: dto.label,
            url: dto.url,
            randoms: dto.serverNames,
            referer: dto.refererUrl ?? "",
            minZoom: Int(dto.zoommin),
            maxZoom: Int(dto.zoommax),
            ellipsoid: dto.isEllipsoid,
            inverted_y: dto.isInvertedY,
            inversiveZoom: false,
            timesupported: dto.timeSupport == "yes",
            expire: Int(dto.timeStoring) ?? 2160,
            tileSize: Int(dto.defaultTileSize) ?? 256,
            bitDensity: 8,
            avgSize: 18000,
            ext: ".png",
            sql: false)
        
        allMapsObjects.append(currentMap)
    }
    
    
    public func getAllMapsJson() -> String {
        let encodedData = try? JSONEncoder().encode(allMapsObjects)
        let jsonString = String(data: encodedData ?? Data(),
                                encoding: .utf8)
        return jsonString ?? ""
    }
    
}






//let a = Osf(myTitle: "AA", price: 12.5, quantity: 5)
//let b =  Osf(myTitle: "BB", price: 41.7, quantity: 07)
//let c = [a, b]
//let encodedData = try? JSONEncoder().encode(c)
//let str = String(data: encodedData!, encoding: .utf8)!
//
//
//struct Osf: Codable {
//  var myTitle:String
//  var price:Double
//  var quantity:Int
//}
