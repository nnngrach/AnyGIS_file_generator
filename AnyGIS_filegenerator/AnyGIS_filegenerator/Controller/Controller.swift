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
            try locusMapsGenerator.create(isShortSet: true, isEnglish: true)
            try locusMapsGenerator.create(isShortSet: false, isEnglish: true)
            try locusMapsGenerator.create(isShortSet: true, isEnglish: false)
            try locusMapsGenerator.create(isShortSet: false, isEnglish: false)
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
            try guruMapsGenerator.create(isShortSet: true, isEnglish: true, appName: .GuruMapsIOS)
            try guruMapsGenerator.create(isShortSet: false, isEnglish: true, appName: .GuruMapsIOS)
            try guruMapsGenerator.create(isShortSet: true, isEnglish: false, appName: .GuruMapsIOS)
            try guruMapsGenerator.create(isShortSet: false, isEnglish: false, appName: .GuruMapsIOS)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForOrux() {
        let ru = patchTemplates.rusLanguageSubfolder
        let en = patchTemplates.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsFullInServer + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsFullInServer + en)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsShortInServer + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOruxMapsShortInServer + en)
        
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
        let ru = patchTemplates.rusLanguageSubfolder
        let en = patchTemplates.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsFull + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsFull + en)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsShort + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMapsShort + en)
        
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
