//
//  WestraParser.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation


class WestraParser {
    
    
    public func generateWestraPassesGeoJson() {
        downloadJson()
    }
    
    
    
    private func downloadJson() {
        let urlString = "https://nakarte.me/westraPasses/westra_passes.json"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            guard let data = data else {return}
            guard error == nil else {return}
            
            
            do {
                let nakartePasses = try JSONDecoder().decode([WestraPassNakarte].self, from: data)
                //print(nakartePasses)
            } catch let error {
                //print(error)
            }
            
        }.resume()
    }
    
    
    
    
    
    private func convertToGeojson(nakartePasses: [WestraPassNakarte]) -> GeoJsonFeatureCollection {
        
        var geoJsonPasses = GeoJsonFeatureCollection(type: "FeatureCollection", features: [])
        
        for pass in nakartePasses {
            
            let geometry = GeoJsonPointGeometry(type: "Point",
                                                coordinates: pass.latlon)
            
            let properties = GeoJsonPassPropertie(ele: pass.elevation ?? "",
                                                  mountain_pass: "yes",
                                                  name: pass.name ?? "",
                                                  natural: "saddle",
                                                  rtsa_scale: pass.grade_eng)
            
            let geoJsonPass = GeoJsonFeature(type: "Feature",
                                                geometry: geometry,
                                                properties: properties)
            
            geoJsonPasses.features.append(geoJsonPass)
        }
        
        return geoJsonPasses
    }
    
    
    private func saveFile() {
        
    }
    
}
