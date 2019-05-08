//
//  WestraParser.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 08/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation


class WestraParser {
    
    private let diskHandler = DiskHandler()
    private let patchTemplates = FilePatchTemplates()
    
    
    public func generateWestraPassesGeoJson() {
        print("Start parsing Westra Passes")
        let urlString = "https://nakarte.me/westraPasses/westra_passes.json"
        guard let url = URL(string: urlString) else {return}
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            guard let data = data else {return}
            guard error == nil else {return}
            
            do {
                
                let nakartePasses = try self.encodeFromJson(data)
                
                let geoJsonPasses = self.convertToGeojson(nakartePasses)
                
                let dataForSaving = try JSONEncoder().encode(geoJsonPasses)
                
                let patch = self.patchTemplates.localPathToGeoJson + "/WestraPasses.geojson"
                let fileUrl = URL(string: patch)!

                try dataForSaving.write(to: fileUrl)
                
                print("Finish parsing Westra Passes")
                
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    
    
    
    
    private func encodeFromJson(_ data: Data) throws -> [WestraPassNakarte]{
        return try JSONDecoder().decode([WestraPassNakarte].self, from: data)
    }
    
    
    
    
    private func convertToGeojson(_ nakartePasses: [WestraPassNakarte]) -> GeoJsonFeatureCollection {
        
        var geoJsonPasses = GeoJsonFeatureCollection(type: "FeatureCollection", features: [])
        
        
        for pass in nakartePasses {
            
            let geometry = GeoJsonPointGeometry(type: "Point",
                                                coordinates: [pass.latlon[1], pass.latlon[0]])
            
            let properties = GeoJsonPassPropertie(ele: pass.elevation ?? "",
                                                  name: pass.name ?? "",
                                                  rtsa_scale: pass.grade_eng,
                                                  is_summit: pass.is_summit ?? 0)
            
            let geoJsonPass = GeoJsonFeature(type: "Feature",
                                                geometry: geometry,
                                                properties: properties)
            
            geoJsonPasses.features.append(geoJsonPass)
        }
        
        return geoJsonPasses
    }
    
    
}
