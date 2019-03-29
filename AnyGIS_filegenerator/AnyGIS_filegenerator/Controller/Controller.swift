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
    
    
    public func generateAll() {
        generateWebPages()
        generateMapsForGuru()
        generateMapsForOrux()
        //generateMapsForOsmand()
        generateMapsForLocus()
        generateInstallersForLocus()
    }
    
    
    public func generateInstallersForLocus() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToInstallers)
        
        do {
            try locusInstallerGeneretor.createSingleMapLoaders()
            try locusInstallerGeneretor.createFolderLoader()
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: true)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForLocus() {
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsFull)
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsShort)
        
        do {
            try locusMapsGenerator.createAll(isShortSet: true)
            try locusMapsGenerator.createAll(isShortSet: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForGuru() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsFull)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsShort)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsInServer)
        
        do {
            try guruMapsGenerator.createAll(isShortSet: true)
            try guruMapsGenerator.createAll(isShortSet: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForOrux() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsFullInServer)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsShortInServer)
        
        do {
            try oruxMapsGenerator.createAll(isShortSet: true)
            try oruxMapsGenerator.createAll(isShortSet: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForOsmand() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsFull)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsShort)
        
        do {
            //try osmandMapsGenerator.createAll(isShortSet: true)
            //try osmandMapsGenerator.createAll(isShortSet: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateWebPages() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToMarkdownPages)
        
        do {
            try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: false)
        } catch {
            print(error)
        }
    }
    
}
