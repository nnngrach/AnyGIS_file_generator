//
//  LocusInstellersGenerator.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class LocusInstallersGenerator {
    
    private let diskHandler = DiskHandler()
    private let baseHandler = SqliteHandler()
    private let webTemplates = WebPageTemplates()
    private let locusTemplates = LocusInstallersTemplates()
    private let patchTemplates = FilePatchTemplates()
    
    
    public func createSingleMapLoaders(isEnglish: Bool) throws {
        
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forLocus else {continue}
            
            let mapFileName = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName
            
            let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
            
            let installerPatch = patchTemplates.localPathToInstallers + langLabel + "__" + mapFileName + ".xml"
            
            
            let content = locusTemplates.getIstallerFileIntro() + locusTemplates.getIstallerFileItem(fileName: mapFileName, isIcon: false, isEnglish: isEnglish) + locusTemplates.getIstallerFileItem(fileName: mapClientLine.groupName, isIcon: true, isEnglish: isEnglish) + locusTemplates.getIstallerFileOutro()
            
            self.diskHandler.createFile(patch: installerPatch, content: content)
            
        }
        
    }
    
    
    
    public func createFolderLoader(isEnglish: Bool) throws {
        
        var content = ""
        var previousFolder = ""
        var isNotFirstString = false
        
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forLocus else {continue}
            
            let mapFileName = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName
            
            if mapClientLine.groupPrefix != previousFolder {
                
                // Last map of the current group.
                // Finish collecting data and write a file.
                if isNotFirstString {
                    finishAndWriteLocusFolderInstaller(folderName: previousFolder, content: content, isEnglish: isEnglish)
                }
                
                // Start collecting data for next group
                isNotFirstString = true
                previousFolder = mapClientLine.groupPrefix
                
                content = locusTemplates.getIstallerFileIntro() + locusTemplates.getIstallerFileItem(fileName: mapClientLine.groupName, isIcon: true, isEnglish: isEnglish) + locusTemplates.getIstallerFileItem(fileName: mapFileName, isIcon: false, isEnglish: isEnglish)
                
            } else {
                
                // Just add current map to group
                content += locusTemplates.getIstallerFileItem(fileName: mapFileName, isIcon: false, isEnglish: isEnglish)
            }
            
            // For last iteration: write collected data to last file
            finishAndWriteLocusFolderInstaller(folderName: previousFolder, content: content, isEnglish: isEnglish)
        }
    }
    
    
    
    private func finishAndWriteLocusFolderInstaller(folderName: String, content: String, isEnglish: Bool) {
        
        let resultContent = content + locusTemplates.getIstallerFileOutro()
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        let installerPatch = patchTemplates.localPathToInstallers + langLabel + "_" + folderName + ".xml"
        
        self.diskHandler.createFile(patch: installerPatch, content: resultContent)
    }
    
    
    
    public func createAllMapsLoader(isShortSet: Bool, isEnglish: Bool) throws {
        
        var previousFolder = ""
        let mapsClientTable = try baseHandler.getMapsClientData(isEnglish: isEnglish)
        let fileName = isShortSet ? "AnyGIS_short_set.xml" : "AnyGIS_full_set.xml"
        
        // Add first part of content
        var content = locusTemplates.getIstallerFileIntro()
        
        // Add all maps and icons
        for mapClientLine in mapsClientTable {
            
            // Filter off service layers
            guard mapClientLine.forLocus else {continue}
            // Filter for short list
            if isShortSet && !mapClientLine.isInStarterSet && !isEnglish {continue}
            if isShortSet && !mapClientLine.isInStarterSetEng && isEnglish {continue}
            
            if mapClientLine.groupName != previousFolder {
                previousFolder = mapClientLine.groupName
                content += locusTemplates.getIstallerFileItem(fileName: mapClientLine.groupName, isIcon: true, isEnglish: isEnglish)
            }
            
            let mapFileName = mapClientLine.groupPrefix + "-" + mapClientLine.clientMapName
            content += locusTemplates.getIstallerFileItem(fileName: mapFileName, isIcon: false, isEnglish: isEnglish)
            
            // Add ending part
            content += locusTemplates.getIstallerFileOutro()
            
            // Create file
            let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
            
            let installerPatch = patchTemplates.localPathToInstallers + langLabel + fileName
            
            self.diskHandler.createFile(patch: installerPatch, content: content)
        }
    }
    
}
