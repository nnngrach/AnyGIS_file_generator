//
//  OsmXmlParser.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 11/05/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class OsmXmlParser: NSObject, XMLParserDelegate {
    
    var currentElementName = String()
    var parserCompletitionHandler: (([OsmWay], [OsmNode]) -> Void)?
    
    var ways: [OsmWay] = []
    var currentWayID = String()
    var currentNodes = [String]()
    var currenrTags = [String : String]()
    
    var nodes: [OsmNode] = []
    var currentNodeID = String()
    var lat = String()
    var lon = String()
    
    
    
    
    
    public func parse(filepath: String, completitionHandler: (([OsmWay], [OsmNode]) -> Void)?){
        
        self.parserCompletitionHandler = completitionHandler
        
        if let path = URL(string: filepath) {
            
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    
    
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        self.currentElementName = elementName
        
        switch elementName {
        case "way":
            currentWayID = attributeDict["id"]!
            currentNodes = [String]()
            currenrTags = [String : String]()
        case "nd":
            currentNodes.append(attributeDict["ref"]!)
        case "tag":
            currenrTags[attributeDict["k"]!] = attributeDict["v"]
        case "node":
            currentNodeID = attributeDict["id"]!
            lat = attributeDict["lat"]!
            lon = attributeDict["lon"]!
        default:
            break
        }
    }
    
    
/*
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.currentElementName == "nd" {
                currentNodes.append(data)
            } else if self.currentElementName == "tag" {
                currenrTags["a"] = data
            }
        }
    }
*/
    
    
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
        case "way":
            let way = OsmWay(id: currentWayID, tags: currenrTags, nodesID: currentNodes)
            ways.append(way)
        case "node":
            let node = OsmNode(id: currentNodeID, lat: lat, lon: lon)
            nodes.append(node)
        default:
            break
        }
    }
    
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletitionHandler?(ways, nodes)
        //print(ways)
    }
    
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
