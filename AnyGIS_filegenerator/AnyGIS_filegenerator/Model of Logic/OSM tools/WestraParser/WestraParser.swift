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
    private let patchTemplates = FilePathTemplates()
    
    
    public func generateGpxFile(forLocus: Bool) {
        let urlWithPassesJson = "https://nakarte.me/westraPasses/westra_passes.json"
        guard let url = URL(string: urlWithPassesJson) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error)  in
            guard error == nil else {return}
            guard let data = data else {return}
            
            self.generateGpxFromFetchedData(data, forLocus)
        }.resume()
    }
    
    
    private func generateGpxFromFetchedData(_ data: Data, _ forLocus: Bool) {
        do {
            let pointsObjects = try self.encodeFromJson(data)
            let gpxPointsContent = forLocus ? self.createGpxContentForLocus(using: pointsObjects) : self.createGpxContentUniversal(using: pointsObjects)
            let gpxFileContent = self.getFullGpxFileContent(with: gpxPointsContent)
            let savingPatch = self.patchTemplates.localPathToGPX + "/WestraPasses.gpx"
            self.diskHandler.createFile(patch: savingPatch, content: gpxFileContent, isWithBOM: false)
        } catch let error {
            print(error)
        }
    }
    
    
    private func encodeFromJson(_ data: Data) throws -> [WestraPassNakarte]{
        return try JSONDecoder().decode([WestraPassNakarte].self, from: data)
    }
    
    
    private func createGpxContentUniversal(using nakartePasses: [WestraPassNakarte]) -> String {
       var pointsBlocks = ""
              
            for point in nakartePasses {

                let grade = point.grade ?? "?"
                let name = point.name ?? "?"
                let elevation = point.elevation ?? "?"
                
                pointsBlocks +=
                """
                <wpt lat="\(point.latlon[0])" lon="\(point.latlon[1])">
                    <name>\(grade) - "\(name)" (\(elevation) m)</name>
                </wpt>

                """
          }
              
          return pointsBlocks
    }
    
        
    private func createGpxContentForLocus(using nakartePasses: [WestraPassNakarte]) -> String {
        var pointsBlocks = ""
        
        for point in nakartePasses {
            
            let name = point.name ?? "?"
            
            var altName = ""
            if let text = point.altnames {altName = " \(text)"}
            
            let gradeEn = point.grade_eng ?? ""
            let elevation = point.elevation ?? ""
            let iconName = point.is_summit == 1 ? "summit_hscc" : "rtsa_scale_\(gradeEn)_hscc"
            
            
            var description = ""
            
            let typeLabel = point.is_summit == 1 ? "Вершина" : "Перевал"
            description += "<p>\(typeLabel) \(name)\(altName)</p>"
            
            if point.grade != nil || point.elevation != nil {
                description += "<p>"
                if point.grade != nil {description += point.grade!}
                if point.grade != nil && point.elevation != nil {description += ", "}
                if point.elevation != nil {description += point.elevation! + "м."}
                description += "</p>"
            }
            
            if let connects = point.connects {
                description += "<p>Соединяет: \(connects)</p>"
            }
            
            if let slopes = point.slopes {
                description += "<p>Склоны: \(slopes)</p>"
            }
            
            if let comments = point.comments {
                description += "<p>Комментарии:<br/>"
                for comment in comments {
                    description += "\(comment.user ?? ""): "
                    description += "<cite>\(comment.content ?? "")</cite><br/>"
                }
                description += "</p>"
            }
            
            if let author = point.author {
                description += "<p>Добавил: \(author)</p>"
            }
 
            
            pointsBlocks +=
            """
            <wpt lat="\(point.latlon[0])" lon="\(point.latlon[1])">
                <name>\(name)</name>
                <ele>\(elevation)</ele>
                <link href="http://westra.ru/passes/Passes/\(point.id!)"/>
                <sym>\(iconName)</sym>
                <extensions>
                    <locus:icon>file:RTSA Scale.zip:\(iconName).png</locus:icon>
                </extensions>
                <desc><![CDATA[\(description)]]></desc>
            </wpt>

            """
        }
        
        return pointsBlocks
    }
    
    
    
    private func getFullGpxFileContent(with pointsContent: String) -> String {
        return """
        <?xml version="1.0" encoding="utf-8" standalone="yes"?>
        <gpx version="1.1"
         xmlns="http://www.topografix.com/GPX/1/1"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd"
         xmlns:gpx_style="http://www.topografix.com/GPX/gpx_style/0/2"
         xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3"
         xmlns:gpxtrkx="http://www.garmin.com/xmlschemas/TrackStatsExtension/v1"
         xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v2">
        \(pointsContent)
        </gpx>
        """
    }
    
    
    
    //MARK: GeoJSON
    /*
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
                
                let patch = self.patchTemplates.localPathToGPX + "/WestraPasses.geojson"
                let fileUrl = URL(string: patch)!

                try dataForSaving.write(to: fileUrl)
                
                print("Finish parsing Westra Passes")
                
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    
    
    private func convertToGeojson(_ nakartePasses: [WestraPassNakarte]) -> GeoJsonFeatureCollection {
        
        var geoJsonPasses = GeoJsonFeatureCollection(type: "FeatureCollection", features: [])
        
        
        for pass in nakartePasses {
            
            let geometry = GeoJsonPointGeometry(type: "Point",
                                                coordinates: [pass.latlon[1], pass.latlon[0]])
            
            let properties = ["ele" : pass.elevation ?? "",
                              "name" : pass.name ?? "",
                              "rtsa_scale" : pass.grade_eng,
                              "is_summit" : String(pass.is_summit ?? 0)]
            
            
            let geoJsonPass = GeoJsonFeature(type: "Feature",
                                                geometry: geometry,
                                                properties: properties)
            
            geoJsonPasses.features.append(geoJsonPass)
        }
        
        return geoJsonPasses
    }
    */
    
}
