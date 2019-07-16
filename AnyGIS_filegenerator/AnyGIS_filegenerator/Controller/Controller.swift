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
    
    private let guruMapsGenerator = GuruAllMapsGenerator()
    private let oruxMapsGenerator = OruxAllMapsGenerator()
    private let locusMapsGenerator = LocusAllMapsGenerator()
    private let osmandMapsGenerator = OsmandAllMapsGenerator()
    private let markdownPagesGenerator = WebPagesAllMapsGenerator()
    private let locusInstallerGeneretor = LocusInstallersGenerator()
    
    private let westraParser = WestraParser()
    //private let bookParser = BookParser()
    private let osmXmlParser = OsmXmlParser()


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
            try locusMapsGenerator.launch(isShortSet: true, isEnglish: true, appName: .Locus)
            try locusMapsGenerator.launch(isShortSet: false, isEnglish: true, appName: .Locus)
            try locusMapsGenerator.launch(isShortSet: true, isEnglish: false, appName: .Locus)
            try locusMapsGenerator.launch(isShortSet: false, isEnglish: false, appName: .Locus)
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
            try guruMapsGenerator.launch(isShortSet: true, isEnglish: true, appName: .GuruMapsIOS)
            try guruMapsGenerator.launch(isShortSet: false, isEnglish: true, appName: .GuruMapsIOS)
            try guruMapsGenerator.launch(isShortSet: true, isEnglish: false, appName: .GuruMapsIOS)
            try guruMapsGenerator.launch(isShortSet: false, isEnglish: false, appName: .GuruMapsIOS)
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
            try oruxMapsGenerator.launch(isShortSet: true, isEnglish: true, appName: .Orux)
            try oruxMapsGenerator.launch(isShortSet: true, isEnglish: false, appName: .Orux)
            try oruxMapsGenerator.launch(isShortSet: false, isEnglish: true, appName: .Orux)
            try oruxMapsGenerator.launch(isShortSet: false, isEnglish: false, appName: .Orux)
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
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMetainfoMapsFull + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMetainfoMapsFull + en)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMetainfoMapsShort + ru)
        diskHandler.cleanFolder(patch: patchTemplates.localPathToOsmandMetainfoMapsShort + en)
        



        do {
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: true, isForSqlitedb: false)
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: false, isForSqlitedb: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: true, isForSqlitedb: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: false, isForSqlitedb: false)
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: true, isForSqlitedb: true)
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: false, isForSqlitedb: true)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: true, isForSqlitedb: true)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: false, isForSqlitedb: true)
        } catch {
            print(error)
        }
    }


    public func generateWebPages() {
        diskHandler.cleanFolder(patch: patchTemplates.localPathToMarkdownPages)

        do {
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: false, appName: .Locus)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: false, appName: .Locus)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: false, appName: .GuruMapsAndroid)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: false, appName: .GuruMapsAndroid)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: false, appName: .GuruMapsIOS)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: false, appName: .GuruMapsIOS)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: false, appName: .Osmand)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: false, appName: .Osmand)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: false, appName: .OsmandMetainfo)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: false, appName: .OsmandMetainfo)

            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: true, appName: .Locus)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: true, appName: .Locus)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: true, appName: .GuruMapsAndroid)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: true, appName: .GuruMapsAndroid)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: true, appName: .GuruMapsIOS)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: true, appName: .GuruMapsIOS)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: true, appName: .Osmand)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: true, appName: .Osmand)
            try markdownPagesGenerator.launch(isShortSet: true, isEnglish: true, appName: .OsmandMetainfo)
            try markdownPagesGenerator.launch(isShortSet: false, isEnglish: true, appName: .OsmandMetainfo)

        } catch {
            print(error)
        }
    }
    
    
    public func parseWestraGeoJson() {
        westraParser.generateWestraPassesGeoJson()
    }
    
    
    public func parseOsmToGeoJson() {
        //let path = "file:///Projects/GIS/Online%20map%20sources/map-sources/Experimantal_area/Osm_Parsing/export.osm"
        let path = "file:///Projects/GIS/Online%20map%20sources/map-sources/Experimantal_area/Osm_Parsing/springs.osm"

        osmXmlParser.parse(filepath: path, completitionHandler: nil)
    }
    
}
