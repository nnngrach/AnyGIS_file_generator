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
    private let zipHandler = ZipHandler()
    private let patches = FilePathTemplates()
    
    private let guruMapsGenerator = GuruAllMapsGenerator()
    private let oruxMapsGenerator = OruxAllMapsGenerator()
    private let locusMapsGenerator = LocusAllMapsGenerator()
    private let osmandMapsGenerator = OsmandAllMapsGenerator()
    private let alpineMapsGenerator = AlpineAllMapsGenerator()
    private let alpineFoldersGenerator = AlpineFoldersGenerator()
    private let markdownPagesGenerator = WebPagesAllMapsGenerator()
    private let locusInstallerGeneretor = LocusInstallersGenerator()
    private let desktopGenerator = DesktopAllMapsGenerator()
    private let sasPlanetGenerator = SasPlanetMapsGenerator()
    
    private let markdownPagesWithMenuGenerator = WebPagesMenuGenerator()
    
//    private let westraParser = WestraParser()
//    private let osmXmlParser = OsmXmlParser()


    public func generateAll() {
        generateWebPages()
        generateMapsForGuru()
        generateMapsForOrux()
        generateMapsForOsmand()
        generateMapsForOsmandMetainfo()
        generateMapsForAlpine()
        generateMapsForLocus()
        generateInstallersForLocus()
        generateMapsForDesktop()
        generateMapsForSasPlanet()
        cleanAndZip()
    }


    public func generateInstallersForLocus() {
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patches.localPathToLocusInstallers + ru)
        diskHandler.cleanFolder(patch: patches.localPathToLocusInstallers + en)

        do {
            try locusInstallerGeneretor.createSingleMapLoaders(isEnglish: true)
            try locusInstallerGeneretor.createSingleMapLoaders(isEnglish: false)
            try locusInstallerGeneretor.createFolderLoader(isEnglish: true)
            try locusInstallerGeneretor.createFolderLoader(isEnglish: false)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: true, isEnglish: true, isUninstaller: false)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: true, isEnglish: false, isUninstaller: false)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false, isEnglish: true, isUninstaller: false)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false, isEnglish: false, isUninstaller: false)
            
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false, isEnglish: true, isUninstaller: true)
            try locusInstallerGeneretor.createAllMapsLoader(isShortSet: false, isEnglish: false, isUninstaller: true)
        } catch {
            print(error)
        }
    }


    public func generateMapsForLocus() {
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsZip, filetype: "zip")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + ru, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + en, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + ru, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + en, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsPrivate + ru, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + ru, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + en, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + ru, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + en, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsPrivate + ru, filetype: "DS_Store")
        
        

        do {
            try locusMapsGenerator.launch(isShortSet: true, isEnglish: true, isPrivateSet: false, appName: .Locus)
            try locusMapsGenerator.launch(isShortSet: false, isEnglish: true, isPrivateSet: false, appName: .Locus)
            try locusMapsGenerator.launch(isShortSet: true, isEnglish: false, isPrivateSet: false, appName: .Locus)
            try locusMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: false, appName: .Locus)
            try locusMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: true, appName: .Locus)
        } catch {
            print(error)
        }
    }


    public func generateMapsForGuru() {
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToGuruMapsZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsFull + ru)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsFull + en)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsShort + ru)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsShort + en)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsPrivate + ru)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsInServer + ru)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsInServer + en)

        do {
            try guruMapsGenerator.launch(isShortSet: true, isEnglish: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try guruMapsGenerator.launch(isShortSet: false, isEnglish: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try guruMapsGenerator.launch(isShortSet: true, isEnglish: false, isPrivateSet: false, appName: .GuruMapsIOS)
            try guruMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: false, appName: .GuruMapsIOS)
            
            try guruMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: true, appName: .GuruMapsIOS)
        } catch {
            print(error)
        }
    }


    public func generateMapsForOrux() {
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsFullInServer + ru)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsFullInServer + en)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsShortInServer + ru)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsShortInServer + en)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsPrivate + ru)

        do {
            try oruxMapsGenerator.launch(isShortSet: true, isEnglish: true, isPrivateSet: false, appName: .Orux)
            try oruxMapsGenerator.launch(isShortSet: true, isEnglish: false, isPrivateSet: false, appName: .Orux)
            try oruxMapsGenerator.launch(isShortSet: false, isEnglish: true, isPrivateSet: false, appName: .Orux)
            try oruxMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: false, appName: .Orux)
            try oruxMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: true, appName: .Orux)
        } catch {
            print(error)
        }
    }


    public func generateMapsForOsmand() {
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToOsmandMapsZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsFull + ru)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsFull + en)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsShort + ru)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsShort + en)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsPrivate + ru)

        do {
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: true, isForSqlitedb: true, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: false, isForSqlitedb: true, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: true, isForSqlitedb: true, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: false, isForSqlitedb: true, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: false, isForSqlitedb: true, isPrivateSet: true)
        } catch {
            print(error)
        }
    }
    
    
    
    public func generateMapsForOsmandMetainfo() {
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToOsmandMetainfoZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoFull + ru)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoFull + en)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoShort + ru)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoShort + en)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoPrivate + ru)
        
        
        
        
        do {
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: true, isForSqlitedb: false, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: true, isEnglish: false, isForSqlitedb: false, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: true, isForSqlitedb: false, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: false, isForSqlitedb: false, isPrivateSet: false)
            try osmandMapsGenerator.launch(isShortSet: false, isEnglish: false, isForSqlitedb: false, isPrivateSet: true)
        } catch {
            print(error)
        }
    }
    
    
    
    public func generateMapsForAlpine() {
        
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToAlpineMapsZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + ru)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + en)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + ru)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + en)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + patches.groupInOneFileSubfolder  + ru)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + patches.groupInOneFileSubfolder  + en)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + patches.groupInOneFileSubfolder  + ru)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + patches.groupInOneFileSubfolder  + en)
        
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsInServer + ru)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsInServer + en)
        
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsPrivate + ru)
        
        
        do {
            
            try alpineFoldersGenerator.createAllFoldersWithMaps(isEnglish: true, isShortSet: true, isPrivateSet: false)
            try alpineFoldersGenerator.createAllFoldersWithMaps(isEnglish: false, isShortSet: true, isPrivateSet: false)
            try alpineFoldersGenerator.createAllFoldersWithMaps(isEnglish: true, isShortSet: false, isPrivateSet: false)
            try alpineFoldersGenerator.createAllFoldersWithMaps(isEnglish: false, isShortSet: false, isPrivateSet: false)

            try alpineMapsGenerator.launch(isShortSet: true, isEnglish: true, isPrivateSet: false, appName: .Alpine)
            try alpineMapsGenerator.launch(isShortSet: false, isEnglish: true, isPrivateSet: false, appName: .Alpine)
            try alpineMapsGenerator.launch(isShortSet: true, isEnglish: false, isPrivateSet: false, appName: .Alpine)
            try alpineMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: false, appName: .Alpine)
            
            try alpineFoldersGenerator.createAllFoldersWithMaps(isEnglish: false, isShortSet: false, isPrivateSet: true)
            
            
        } catch {
            print(error)
        }
    }
    
    
    
    
    public func generateMapsForDesktop() {
        let ru = patches.rusLanguageSubfolder
        let en = patches.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patches.localPathToDesktopMaps + ru)
        diskHandler.cleanFolder(patch: patches.localPathToDesktopMaps + en)
        diskHandler.cleanFolder(patch: patches.localPathToDesktopMapsPrivate + ru)
    
        do {
            try desktopGenerator.launch(isEnglish: true, isPrivateSet: false)
            try desktopGenerator.launch(isEnglish: false, isPrivateSet: false)
            try desktopGenerator.launch(isEnglish: false, isPrivateSet: true)

        } catch {
            print(error)
        }
    }
    
    
    
    private func cleanAndZip() {

        diskHandler.cleanFolder(patch: patches.localPathToPrivateSetZip )
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToPrivateSetFolder, filetype: "DS_Store")

        do {
            zipHandler.zip(sourcePath: patches.localPathToPrivateSetFolder, archievePath: patches.localPathToPrivateSetZip + "Anygis_additional_maps.zip")
        } catch {
            print(error)
        }
    }
    
    
    
    
    public func generateMapsForSasPlanet() {
        
        diskHandler.cleanFolder(patch: patches.localPathToSasPlanetMaps)
        diskHandler.cleanFolder(patch: patches.localPathToSasPlanetInGitFolder)
    
        do {
            try sasPlanetGenerator.launch(isSavingInGitFolder: true)
            try sasPlanetGenerator.launch(isSavingInGitFolder: false)

        } catch {
            print(error)
        }
    }
    
    


    public func generateWebPages() {
        diskHandler.cleanFolder(patch: patches.localPathToMarkdownPages)

        do {
            
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .Locus)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Locus)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .GuruMapsAndroid)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .GuruMapsAndroid)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .GuruMapsIOS)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .Osmand)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Osmand)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .OsmandMetainfo)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .OsmandMetainfo)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .Alpine)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Alpine)
            try markdownPagesWithMenuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Desktop)

            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .Locus)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Locus)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .GuruMapsAndroid)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .GuruMapsAndroid)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .GuruMapsIOS)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .Osmand)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Osmand)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .OsmandMetainfo)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .OsmandMetainfo)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .Alpine)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Alpine)
            try markdownPagesWithMenuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Desktop)
  
        } catch {
            print(error)
        }
    }
    
    
    
    /*
    public func parseWestraGeoJson() {
        westraParser.generateWestraPassesGeoJson()
    }
    
    
     
    public func parseOsmToGeoJson() {
        //let path = "file:///Projects/GIS/Online%20map%20sources/map-sources/Experimantal_area/Osm_Parsing/export.osm"
        let path = "file:///Projects/GIS/Online%20map%20sources/map-sources/Experimantal_area/Osm_Parsing/springs.osm"

        osmXmlParser.parse(filepath: path, completitionHandler: nil)
    }
    */
    
}
