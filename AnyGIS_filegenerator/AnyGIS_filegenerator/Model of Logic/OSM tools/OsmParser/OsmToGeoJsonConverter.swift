//
//  OsmToGeoJsonConverter.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 11/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//


/*
import Foundation

class OsmToGeoJsonConverter {
    
    
    func convertNode(nodes: [OsmNode]) -> GeoJsonFeatureCollection {
        
        var geoJson = GeoJsonFeatureCollection(type: "FeatureCollection", features: [])
        
        for node in nodes {
            
            var properties = [String : String]()
            
            for tag in node.tags {
                properties[tag.key] = tag.value
            }
            
            
            let geometry = GeoJsonPointGeometry(type: "Point",
                                                coordinates: [node.lat, node.lon])
            
            let currentFeature = GeoJsonFeature(type: "Feature",
                                                geometry: geometry,
                                                properties: properties)
            
            geoJson.features.append(currentFeature)
        }
        
        return geoJson
    }
    
    
    
    
    
    func converWay(ways: [OsmWay], nodes: [OsmNode]) {
        
        var geoJson = GeoJsonFeatureCollection(type: "FeatureCollection", features: [])
        
        for way in ways {
            
            var properties = [String : String]()
            
            for tag in way.tags {
                properties[tag.key] = tag.value
            }
            
            let geometry = GeoJsonPointGeometry(type: "LineString",
                                                coordinates: [])
        }
        
    }
    
    
    
    
}
*/

