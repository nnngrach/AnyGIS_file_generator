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
    private let patches = FilePathTemplates()
    private let menuTemplates = WebMenuPageTemplates()
    private let abstractOneMapGenerator = AbstractOneMapGenerator()
    
    
    
    
    public func launch(isEnglish: Bool, isShortSet: Bool, appName: ClientAppList) throws {
        
        let foldersStructure = try prepareFoldersStructure(isEnglish: isEnglish, isShortSet: isShortSet, appName: appName)
        
        let generatedHtmlContent = generateHtmlFrom(foldersStructure: foldersStructure, isEnglish: isEnglish, appName: appName)
        
        
        let htmlTemplates = getHtmlPart(isEnglish: isEnglish, isShortSet: isShortSet, appName: appName)
        
        let fileContent = htmlTemplates.intro + generatedHtmlContent + htmlTemplates.outro

        saveHtmlPageFile(content: fileContent, isEnglish: isEnglish, isShortSet: isShortSet, appName: appName)
    }
  
    
    
    

    private func prepareFoldersStructure(isEnglish: Bool, isShortSet: Bool, appName: ClientAppList) throws -> MenuFolderItem {
        
        
        var foldersStructure = MenuFolderItem(order: 0, orderEn: 0, name: "root", fullPathEn: "", groupFilePrefix: "", maps: [], subFolders: [:])
        var previousFolderPath = ""
        
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        

        
        for mapClientLine in mapsClientTable {
            
            //Filtering
            let isItUnnecessaryMap = abstractOneMapGenerator.isItUnnecessaryMap(mapClientLine, isShortSet, isEnglish, appName)
            
            if isItUnnecessaryMap {continue}
            
            
            
            // Separate names of subfolders
            let currentFolderPath = isEnglish ? mapClientLine.groupNameEng : mapClientLine.groupName
            let currentGroupSubFolders = sepateteToSubFolders(groupName: currentFolderPath)
            let currentGroupSubFoldersEn = sepateteToSubFolders(groupName: mapClientLine.groupNameEng)
            
            
            // Fill folders fields (if it need)
            if currentFolderPath != previousFolderPath {
                foldersStructure.recursiveFolderCreator(chekingFolders: currentGroupSubFolders, chekingFoldersEn: currentGroupSubFoldersEn, fullFolderPathEn: mapClientLine.groupNameEng, folderFilePrefix: mapClientLine.groupPrefix, order: mapClientLine.orderRu, orderEn: mapClientLine.orderEng, index: 0)
            }
            
            
            // Fill map field
            let mapPrevievLine = try baseHandler.getMapsPreviewBy(name: mapClientLine.anygisMapName)
            
            foldersStructure.recursiveAdd(name: mapClientLine.shortName, nameEn: mapClientLine.shortNameEng, hasPreview: mapPrevievLine?.hasPrewiew ?? false, anygisMapName: mapClientLine.anygisMapName, fileGroupPrefix: mapClientLine.groupPrefix, fileName: mapClientLine.clientMapName, chekingFolders: currentGroupSubFolders, index: 0)
        }

        return foldersStructure
    }
    
    
    
    
    func generateHtmlFrom(foldersStructure: MenuFolderItem, isEnglish: Bool, appName: ClientAppList) -> String {
        
        var content = menuTemplates.getMenuIntro()
        
        let sortedFolderList = getSortedSubfolders(foldersStructure: foldersStructure, isEnglish: isEnglish)
        
        for subFolder in sortedFolderList {
            content += recursiveGenerateHtmlBlock(subFolder, folderLevel: 0, isEnglish: isEnglish, appName: appName)
        }
        
        content += menuTemplates.getMenuOutro()
        
        return content
    }
    
    
    
    
    
    
    
    private func recursiveGenerateHtmlBlock(_ foldersStructure: MenuFolderItem, folderLevel: Int, isEnglish: Bool, appName: ClientAppList) -> String {
        
        var content = ""
        
        // Add block intro
        if folderLevel == 0 {
            content += menuTemplates.getFirstLevelFolderIntro(folderName: foldersStructure.name, fullFolderPathEn: foldersStructure.fullPathEn, folderFilePrefix: foldersStructure.groupFilePrefix, isEnglish: isEnglish, appName: appName)
        } else {
            content += menuTemplates.getSubLevelFolderIntro(folderName: foldersStructure.name, fullFolderPathEn: foldersStructure.fullPathEn, folderFilePrefix: foldersStructure.groupFilePrefix, isEnglish: isEnglish, appName: appName)
        }
        
        
        // add maps
        if foldersStructure.maps.count > 0 {
            for map in foldersStructure.maps {
                content += menuTemplates.getMapItem(isEnglish: isEnglish, appName: appName, mapObject: map)
            }
        }
        
        
        
        // recursive add submenu
        
        if foldersStructure.subFolders.count > 0 {
            
            let sortedSubFolderList = getSortedSubfolders(foldersStructure: foldersStructure, isEnglish: isEnglish)
            
            for subFolder in sortedSubFolderList {
                content += recursiveGenerateHtmlBlock(subFolder, folderLevel: folderLevel+1, isEnglish: isEnglish, appName: appName)
            }
        }
        
        
        // Add block outro
        if folderLevel == 0 {
            content += menuTemplates.getFirstLevelFolderOutro()
        } else {
            content += menuTemplates.getSubLevelFolderOutro()
        }
        
        return content
    }
    
    
    
    
    private func getHtmlPart(isEnglish: Bool, isShortSet: Bool, appName: ClientAppList) -> (intro: String, outro: String) {
        
        var content = ""
        
        let htmlTemplateFile = diskHandler.readFile(at: patches.localPathToJekillHtmlTemplate)
        var htmlParts = menuTemplates.fillStubsInHtmlPageTemplate(htmlTemplateFile)
        
        
        htmlParts.intro += menuTemplates.getHeaderMenu(isEnglish: isEnglish)
        htmlParts.intro += menuTemplates.getHeaderLabel(isEnglish: isEnglish, appName: appName)
        htmlParts.intro += menuTemplates.getMenuIntro()
        
        return htmlParts
    }
    
    
    
    
    
    private func saveHtmlPageFile(content: String, isEnglish: Bool, isShortSet: Bool, appName: ClientAppList) {
        
        let firstPart = patches.localPathToMarkdownPages
        let secondPart = appName.rawValue.replacingOccurrences(of: " ", with: "_")
        let thirdPart = isShortSet ? "_Short" : "_Full"
        let lastPart = isEnglish ? "_en.html" : "_ru.html"
        let savingPath = firstPart + secondPart + thirdPart + lastPart
        
        diskHandler.createFile(patch: savingPath, content: content, isWithBOM: false)
    }
    
    
    
    
    private func sepateteToSubFolders(groupName: String) -> [String] {
        
        // Join Overlay subfolder
        let overlayRuForReplacing = "Слои - "
        let overlayEnForReplacing = "Overlay - "
        let overlayRuStub = "{Over_RU}"
        let overlayEnStub = "{Over_En}"
        
        var preparedGroupName = groupName.replacingOccurrences(of: overlayRuForReplacing, with: overlayRuStub)
        preparedGroupName = preparedGroupName.replacingOccurrences(of: overlayEnForReplacing, with: overlayEnStub)
        
        
        // Splitting
        preparedGroupName = preparedGroupName.replacingOccurrences(of: " - ", with: "/")
        
        var parentFolderMenuItems = preparedGroupName
            .split(separator: "/")
            .map{String($0)}
        
        
        // Restore Overlay text in label
        parentFolderMenuItems[0] = parentFolderMenuItems[0].replacingOccurrences(of: overlayRuStub, with: overlayRuForReplacing)
        parentFolderMenuItems[0] = parentFolderMenuItems[0].replacingOccurrences(of: overlayEnStub, with: overlayEnForReplacing)
        
        return parentFolderMenuItems
    }
    
    
    
    
    private func getSortedSubfolders(foldersStructure: MenuFolderItem, isEnglish: Bool) -> [MenuFolderItem] {
        
        if isEnglish {
            return foldersStructure.subFolders.values.sorted(by: {$0.orderEn < $1.order})
        } else {
            return foldersStructure.subFolders.values.sorted(by: {$0.order < $1.orderEn})
        }
    }
    
}
