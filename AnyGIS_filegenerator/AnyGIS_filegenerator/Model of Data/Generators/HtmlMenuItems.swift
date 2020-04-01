//
//  HtmlMenuItems.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 12/02/2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

struct MenuFolderItem {
    
    var order: Int64
    var orderEn: Int64
    
    var name: String
    var fullPathEn: String
    var groupFilePrefix: String
    
    var maps: [MenuMapItem]
    var subFolders: [String: MenuFolderItem]
    
    func containFolder(_ subFolderName: String) -> Bool {
        if subFolders.count == 0 {return false}
        
        for subFolder in subFolders {
            if subFolder.key == subFolderName {return true}
        }
        
        return false
    }
    
    
    
    mutating func recursiveFolderCreator(chekingFolders: [String], chekingFoldersEn: [String], fullFolderPathEn:String, folderFilePrefix: String, order: Int64, orderEn: Int64, index: Int) {
        
        if index == chekingFolders.count {return}
        
        let currentCheckingFolderName = chekingFolders[index]
        //let currentCheckingFolderNameEn = chekingFoldersEn[index]
        
        if !self.containFolder(currentCheckingFolderName) {
            
            let pathToCurrentFolder = getFullFathToCurrentFolder(subfolderNames: chekingFoldersEn, currentFolderLevel: index)
            
            self.subFolders[currentCheckingFolderName] = MenuFolderItem(order: order, orderEn: orderEn, name: currentCheckingFolderName, fullPathEn: pathToCurrentFolder, groupFilePrefix: folderFilePrefix, maps: [], subFolders: [:])
        }
        
        self.subFolders[currentCheckingFolderName]?.recursiveFolderCreator(chekingFolders: chekingFolders, chekingFoldersEn: chekingFoldersEn, fullFolderPathEn: fullFolderPathEn, folderFilePrefix: folderFilePrefix, order: order, orderEn: orderEn, index: index+1)
    }
    
    
    
    
    private func getFullFathToCurrentFolder(subfolderNames: [String], currentFolderLevel: Int) -> String {
        
        var pathToCurrentFolder = ""
        
        for i in 0 ... currentFolderLevel {
            pathToCurrentFolder += subfolderNames[i]
            
            if i < currentFolderLevel {
               pathToCurrentFolder += " - "
            }
        }
        
        return pathToCurrentFolder
    }
    
    
    
    mutating func recursiveAdd(name: String, nameEn: String, hasPreview: Bool, anygisMapName: String, fileGroupPrefix: String, fileName: String, chekingFolders: [String], index: Int) {
        
        if index == chekingFolders.count {
            self.maps.append(MenuMapItem(name: name, nameEn: nameEn, hasPreview: hasPreview, anygisMapName: anygisMapName, fileGroupPrefix: fileGroupPrefix, fileName: fileName))
            return
        }
        
        let currentCheckingFolderName = chekingFolders[index]
        
        self.subFolders[currentCheckingFolderName]?.recursiveAdd(name: name, nameEn: nameEn, hasPreview: hasPreview, anygisMapName: anygisMapName, fileGroupPrefix: fileGroupPrefix, fileName: fileName, chekingFolders: chekingFolders, index: index+1)
    }

}




struct MenuMapItem {
    var name: String
    var nameEn: String
    var hasPreview: Bool
    var anygisMapName: String
    var fileGroupPrefix: String
    var fileName: String
}
