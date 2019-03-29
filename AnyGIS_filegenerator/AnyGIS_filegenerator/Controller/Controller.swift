//
//  Controller.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

class Controller {
    
    private let diskHandler = DiskHandler()
    private let patchTemplates = FilePatchTemplates()
    
    private let locusInstallerGeneretor = LocusInstallersGenerator()
    private let markdownPagesGenerator = MarkdownPagesGenerator()
    private let guruMapsGenerator = GuruMapsGenerator()
    private let oruxMapsGenerator = OruxMapsGenerator()
    private let locusMapsGenerator = LocusMapsGenerator()
    
    public func generateAll() throws {
        
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsFull)
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsShort)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsFull)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsShort)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsInServer)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsFull)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsShort)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsFullInServer)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsShortInServer)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToInstallers)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToMarkdownPages)

        try locusInstallerGeneretor.createSingleMapLoaders()
        try locusInstallerGeneretor.createFolderLoader()
        try locusInstallerGeneretor.createAllMapsLoader(isShortSet: true)
        try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false)

        try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: true)
        try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: false)
        try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: true)
        try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: false)
        try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: true)
        try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: false)

        try guruMapsGenerator.createAll(isShortSet: true)
        try guruMapsGenerator.createAll(isShortSet: false)
        try oruxMapsGenerator.createAll(isShortSet: true)
        try oruxMapsGenerator.createAll(isShortSet: false)
        try locusMapsGenerator.createAll(isShortSet: true)
        try locusMapsGenerator.createAll(isShortSet: false)
        //try osmandMapsGenerator.createAll(isShortSet: true)
        //try osmandMapsGenerator.createAll(isShortSet: false)
        
        
        //let patch = "file:///Projects/GIS/AnyGIS_file_generator/AnyGIS_filegenerator/AnyGIS_filegenerator/testing"
//        let patch = "file:///Users/macbookpro15/Downloads/"
//        let patch = "file:///Projects/GIS/"
        
//        diskHandler.createFile(patch: patch+"1.txt", content: "qwe")
        
        //diskHandler.cleanFolder(patch: patch)
    }
    
    
    public func generateInstallersForLocus() {
        
    }
    
    
    public func generateMapsForLocus() {
        
    }
    
    
    public func generateMapsForGuru() {
        
    }
    
    
    public func generateMapsForOrux() {
        
    }
    
    
    public func generateMapsForOsmand() {
        
    }
    
    
    public func generateWebPages() {
        
    }
    
}
