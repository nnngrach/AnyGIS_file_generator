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
    
    private let guruMapsGenerator = GuruMapsGenerator()
    private let oruxMapsGenerator = OruxMapsGenerator()
    private let locusMapsGenerator = LocusMapsGenerator()
    private let osmandMapsGenerator = OsmandMapsGenerator()
    private let markdownPagesGenerator = MarkdownPagesGenerator()
    private let locusInstallerGeneretor = LocusInstallersGenerator()
    
    
    public func generateAll() {
        generateWebPages()
        generateMapsForGuru()
        generateMapsForOrux()
        generateMapsForOsmand()
        generateMapsForLocus()
        generateInstallersForLocus()
    }
    
    
    public func generateInstallersForLocus() {
        let ru = patchTemplates.rusLanguageSubfolder
        let en = patchTemplates.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patchTemplates.localPathToInstallers + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToInstallers + en)
        
        do {
            try locusInstallerGeneretor.createSingleMapLoaders(isEnglish: true)
            try locusInstallerGeneretor.createSingleMapLoaders(isEnglish: false)
            try locusInstallerGeneretor.createFolderLoader(isEnglish: true)
            try locusInstallerGeneretor.createFolderLoader(isEnglish: false)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: true, isEnglish: true)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: true, isEnglish: false)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false, isEnglish: true)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false, isEnglish: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForLocus() {
        let ru = patchTemplates.rusLanguageSubfolder
        let en = patchTemplates.engLanguageSubfolder
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsFull + ru)
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsFull + en)
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsShort + ru)
        diskHandler.cleanXmlFromFolder(patch: patchTemplates.localPathToLocusMapsShort + en)

        
        do {
            try locusMapsGenerator.createAll(isShortSet: true, isEnglish: true)
            try locusMapsGenerator.createAll(isShortSet: false, isEnglish: true)
            try locusMapsGenerator.createAll(isShortSet: true, isEnglish: false)
            try locusMapsGenerator.createAll(isShortSet: false, isEnglish: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForGuru() {
        let ru = patchTemplates.rusLanguageSubfolder
        let en = patchTemplates.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsFull + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsFull + en)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsShort + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsShort + en)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsInServer + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToGuruMapsInServer + en)
        
        do {
            try guruMapsGenerator.createAll(isShortSet: true, isEnglish: true)
            try guruMapsGenerator.createAll(isShortSet: false, isEnglish: true)
            try guruMapsGenerator.createAll(isShortSet: true, isEnglish: false)
            try guruMapsGenerator.createAll(isShortSet: false, isEnglish: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForOrux() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsFullInServer)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsShortInServer)
        
        do {
            try oruxMapsGenerator.createAll(isShortSet: true, isEnglish: true)
            try oruxMapsGenerator.createAll(isShortSet: true, isEnglish: false)
            try oruxMapsGenerator.createAll(isShortSet: false, isEnglish: true)
            try oruxMapsGenerator.createAll(isShortSet: false, isEnglish: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForOsmand() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsFull)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsShort)
        
        do {
            try osmandMapsGenerator.createAll(isShortSet: true, isEnglish: true)
            try osmandMapsGenerator.createAll(isShortSet: true, isEnglish: false)
            try osmandMapsGenerator.createAll(isShortSet: false, isEnglish: true)
            try osmandMapsGenerator.createAll(isShortSet: false, isEnglish: false)
        } catch {
            print(error)
        }
    }
    
    
    public func generateWebPages() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToMarkdownPages)
        
        do {
            try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: true, isEnglish: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: false, isEnglish: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: true, isEnglish: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: false, isEnglish: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: true, isEnglish: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: false, isEnglish: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .Osmand, isShortSet: true, isEnglish: false)
            try markdownPagesGenerator.createMarkdownPage(appName: .Osmand, isShortSet: false, isEnglish: false)
            
            try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: true, isEnglish: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .Locus, isShortSet: false, isEnglish: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: true, isEnglish: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsAndroid, isShortSet: false, isEnglish: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: true, isEnglish: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .GuruMapsIOS, isShortSet: false, isEnglish: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .Osmand, isShortSet: true, isEnglish: true)
            try markdownPagesGenerator.createMarkdownPage(appName: .Osmand, isShortSet: false, isEnglish: true)
        } catch {
            print(error)
        }
    }
    
}
