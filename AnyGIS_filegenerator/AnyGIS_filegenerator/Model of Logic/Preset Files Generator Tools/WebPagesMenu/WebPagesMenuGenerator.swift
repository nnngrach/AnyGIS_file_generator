//
//  WebPagesMenuGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 20/01/2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

class WebPagesMenuGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let patches = FilePatchTemplates()
    private let abstractOneMapGenerator = AbstractOneMapGenerator()
    
    struct menuItem {
        var id: Int64
        var name: String
        var fullName: String
        var maps: [String]
        var folders: [String]
    }
    
    public func launch(isEnglish: Bool, appName: ClientAppList) throws {
        
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        //let mapsServerTable = try baseHandler.getMapsServerData()
        
        var menuItemList = [String: menuItem]()
        
            

        for mapClientLine in mapsClientTable {
            
            //temp - for testing purposes
            if mapClientLine.orderEng < 100 {continue}
            
            let isItUnnecessaryMap = abstractOneMapGenerator.isItUnnecessaryMap(mapClientLine, false, isEnglish, appName)
            
            if isItUnnecessaryMap {continue}
            
            
            
            // Check existiong of parent folder
            
            let parrentFolder = "root/" + mapClientLine.groupNameEng
            
            let parentFolderMenuItems = parrentFolder.split(separator: "/")
            
            
            // If Parrent folder already exist then just add current map to it
            
            if menuItemList[parrentFolder] != nil {
                
                menuItemList[parrentFolder]!.maps.append(mapClientLine.shortNameEng)
             
                
            // Create Parrent folder with current map
                
            } else {
                
                // Creating Parrent
                
                menuItemList[parrentFolder] = menuItem(id: mapClientLine.orderEng, name: String(parentFolderMenuItems.last!), fullName: mapClientLine.groupNameEng, maps: [mapClientLine.shortNameEng], folders: [])
                
                
                
                let grandParentMenuPath = parentFolderMenuItems[0 ..< parentFolderMenuItems.count - 1]
                
                let grandParentFolder = grandParentMenuPath.joined(separator: "/")
                
                let parentFolderName = String(parentFolderMenuItems.last!)
                
                
                // Add link to Parrent in GrandParent
                
                if menuItemList[grandParentFolder] != nil {
                    
                    if !menuItemList[grandParentFolder]!.folders
                        .contains(parentFolderName) {
                        menuItemList[grandParentFolder]!.folders
                            .append(parentFolderName)
                    }
                    
                // For first item only: create 'ROOT' menu folder
                // with link to Parrent
                    
                } else {
                    
                    menuItemList[grandParentFolder] = menuItem(id: 0, name: String(grandParentFolder), fullName: mapClientLine.groupNameEng, maps: [], folders: [parentFolderName])
                }
                
            }
            
        }
        
        //result
        //print(menuItemList)
        
        //print(UUID().uuidString)
    }
    
    
    
}
