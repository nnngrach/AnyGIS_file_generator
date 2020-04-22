import Foundation

class Controller {

    private let diskHandler = DiskHandler()
    private let zipHandler = ZipHandler()
    private let patches = FilePathTemplates()

    private let guruGenerator = GuruAllMapsGenerator()
    private let oruxMapsGenerator = OruxAllMapsGenerator()
    private let locusMapsGenerator = LocusAllMapsGenerator()
    private let osmandGenerator = OsmandAllMapsGenerator()
    private let osmandOsfGenerator = OsfHandler()
    private let alpineMapsGenerator = AlpineAllMapsGenerator()
    private let alpineFolderGenerator = AlpineFoldersGenerator()
    private let markdownPagesGenerator = WebPagesAllMapsGenerator()
    private let locusInstallerGeneretor = LocusInstallersGenerator()
    private let desktopGenerator = DesktopAllMapsGenerator()
    private let sasPlanetGenerator = SasPlanetMapsGenerator()
    private let menuGenerator = WebPagesMenuGenerator()
    private let webPagesListGenerator = WebPagesMapsListGenerator()

    public func generateAll() {
        generateWebPages()
        generateMapsForGuru()
        generateMapsForOrux()
        generateMapsForOsmand()
        generateMapsForOsmandMetainfo()
        generateMapsForOsmandOsf()
        generateMapsForAlpine()
        generateMapsForLocus()
        generateInstallersForLocus()
        generateMapsForDesktop()
        generateMapsForSasPlanet()
        cleanAndZip()
    }

    public func generateInstallersForLocus() {
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patches.localPathToLocusInstallers + rus)
        diskHandler.cleanFolder(patch: patches.localPathToLocusInstallers + eng)

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
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsZip, filetype: "zip")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + rus, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + eng, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + rus, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + eng, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsPrivate + rus, filetype: "xml")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + rus, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsFull + eng, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + rus, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsShort + eng, filetype: "DS_Store")
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToLocusMapsPrivate + rus, filetype: "DS_Store")

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
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToGuruMapsZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsFull + rus)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsFull + eng)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsShort + rus)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsShort + eng)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsPrivate + rus)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsInServer + rus)
        diskHandler.cleanFolder(patch: patches.localPathToGuruMapsInServer + eng)

        do {
            try guruGenerator.launch(isShortSet: true, isEnglish: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try guruGenerator.launch(isShortSet: false, isEnglish: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try guruGenerator.launch(isShortSet: true, isEnglish: false, isPrivateSet: false, appName: .GuruMapsIOS)
            try guruGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: false, appName: .GuruMapsIOS)

            try guruGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: true, appName: .GuruMapsIOS)
        } catch {
            print(error)
        }
    }

    public func generateMapsForOrux() {
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsFullInServer + rus)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsFullInServer + eng)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsShortInServer + rus)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsShortInServer + eng)
        diskHandler.cleanFolder(patch: patches.localPathToOruxMapsPrivate + rus)

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
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToOsmandMapsZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsFull + rus)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsFull + eng)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsShort + rus)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsShort + eng)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMapsPrivate + rus)

        do {
            try osmandGenerator.launch(isShortSet: true, isEnglish: true, fileFormat: .sqlitedb, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: true, isEnglish: false, fileFormat: .sqlitedb, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: false, isEnglish: true, fileFormat: .sqlitedb, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: false, isEnglish: false, fileFormat: .sqlitedb, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: false, isEnglish: false, fileFormat: .sqlitedb, isPrivateSet: true)
        } catch {
            print(error)
        }
    }

    public func generateMapsForOsmandMetainfo() {
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToOsmandMetainfoZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoFull + rus)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoFull + eng)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoShort + rus)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoShort + eng)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandMetainfoPrivate + rus)

        do {
            try osmandGenerator.launch(isShortSet: true, isEnglish: true, fileFormat: .metainfo, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: true, isEnglish: false, fileFormat: .metainfo, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: false, isEnglish: true, fileFormat: .metainfo, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: false, isEnglish: false, fileFormat: .metainfo, isPrivateSet: false)
            try osmandGenerator.launch(isShortSet: false, isEnglish: false, fileFormat: .metainfo, isPrivateSet: true)
        } catch {
            print(error)
        }
    }
    
    
    public func generateMapsForOsmandOsf() {
        
        diskHandler.cleanFolder(patch: patches.localPathToOsmandOsfFiles)
        diskHandler.cleanFolder(patch: patches.localPathToOsmandOsfPluginFolder)

        do {
            try osmandOsfGenerator.launch(fileFormat: .sqlitedb, isEnglish: false)
        } catch {
            print(error)
        }
    }
    
    

    public func generateMapsForAlpine() {
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFiletypeFromFolder(patch: patches.localPathToAlpineMapsZip, filetype: "zip")
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + rus)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + eng)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + rus)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + eng)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + patches.groupInOneFileSubfolder  + rus)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsFull + patches.groupInOneFileSubfolder  + eng)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + patches.groupInOneFileSubfolder  + rus)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsShort + patches.groupInOneFileSubfolder  + eng)

        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsInServer + rus)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsInServer + eng)
        diskHandler.cleanFolder(patch: patches.localPathToAlpineMapsPrivate + rus)

        do {

            try alpineFolderGenerator.createAllFoldersWithMaps(isEnglish: true, isShortSet: true, isPrivateSet: false)
            try alpineFolderGenerator.createAllFoldersWithMaps(isEnglish: false, isShortSet: true, isPrivateSet: false)
            try alpineFolderGenerator.createAllFoldersWithMaps(isEnglish: true, isShortSet: false, isPrivateSet: false)
            try alpineFolderGenerator.createAllFoldersWithMaps(isEnglish: false, isShortSet: false, isPrivateSet: false)

            try alpineMapsGenerator.launch(isShortSet: true, isEnglish: true, isPrivateSet: false, appName: .Alpine)
            try alpineMapsGenerator.launch(isShortSet: false, isEnglish: true, isPrivateSet: false, appName: .Alpine)
            try alpineMapsGenerator.launch(isShortSet: true, isEnglish: false, isPrivateSet: false, appName: .Alpine)
            try alpineMapsGenerator.launch(isShortSet: false, isEnglish: false, isPrivateSet: false, appName: .Alpine)

            try alpineFolderGenerator.createAllFoldersWithMaps(isEnglish: false, isShortSet: false, isPrivateSet: true)
        } catch {
            print(error)
        }
    }

    public func generateMapsForDesktop() {
        let rus = patches.rusLanguageSubfolder
        let eng = patches.engLanguageSubfolder
        diskHandler.cleanFolder(patch: patches.localPathToDesktopMaps + rus)
        diskHandler.cleanFolder(patch: patches.localPathToDesktopMaps + eng)
        diskHandler.cleanFolder(patch: patches.localPathToDesktopMapsPrivate + rus)

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

        zipHandler.zip(sourcePath: patches.localPathToPrivateSetFolder,
                       archievePath: patches.localPathToPrivateSetZip + "Anygis_additional_maps.zip")
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
            try webPagesListGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Locus)

            try menuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .Locus)
            try menuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Locus)
            try menuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .GuruMapsAndroid)
            try menuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .GuruMapsAndroid)
            try menuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try menuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .GuruMapsIOS)
            try menuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .Osmand)
            try menuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Osmand)
            try menuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .OsmandMetainfo)
            try menuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .OsmandMetainfo)
            try menuGenerator.launch(isEnglish: false, isShortSet: true, isPrivateSet: false, appName: .Alpine)
            try menuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Alpine)
            try menuGenerator.launch(isEnglish: false, isShortSet: false, isPrivateSet: false, appName: .Desktop)

            try menuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .Locus)
            try menuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Locus)
            try menuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .GuruMapsAndroid)
            try menuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .GuruMapsAndroid)
            try menuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .GuruMapsIOS)
            try menuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .GuruMapsIOS)
            try menuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .Osmand)
            try menuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Osmand)
            try menuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .OsmandMetainfo)
            try menuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .OsmandMetainfo)
            try menuGenerator.launch(isEnglish: true, isShortSet: true, isPrivateSet: false, appName: .Alpine)
            try menuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Alpine)
            try menuGenerator.launch(isEnglish: true, isShortSet: false, isPrivateSet: false, appName: .Desktop)
        } catch {
            print(error)
        }
    }

}
