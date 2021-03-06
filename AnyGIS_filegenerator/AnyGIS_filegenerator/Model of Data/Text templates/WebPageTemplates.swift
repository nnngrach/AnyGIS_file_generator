//
//  WebPagesTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct WebPageTemplates {
    
    private let patchTemplates = FilePathTemplates()
    
    
    //MARK: Header links
    
    let indexPage = "https://anygis.ru/index"
    let descriptionPage = "https://anygis.ru/Web/Html/Description"
    let rusOutdoorPage = "https://anygis.ru/Web/Html/RusOutdoor"
    let downloadPage = "https://anygis.ru/Web/Html/DownloadPage"
    let locusPage = "https://anygis.ru/Web/Html/Locus"
    let guruPage = "https://anygis.ru/Web/Html/Galileo"
    let oruxPage = "https://anygis.ru/Web/Html/Orux"
    let osmandPage = "https://anygis.ru/Web/Html/Osmand"
    let alpinePage = "https://anygis.ru/Web/Html/Alpine"
    let desktopPage = "https://anygis.ru/Web/Html/Desktop"
    let apiPage = "https://anygis.ru/Web/Html/Api"
    let changeLogPage = "https://anygis.ru/Web/Html/Changelog"

    
    let anygisMapUrlsTemplate = "https://anygis.ru/api/v1/{mapName}/{x}/{y}/{z}"
   
    let email = "anygis@bk.ru"
    
    
    
    //MARK: Templates for Markdown page generation
    
    func getMarkdownHeader(isEnglish: Bool) -> String {
        
        let jekyllHeader = """
        ---
        layout: default
        ---

        """
        
        let buttonsRu = "| [AnyGIS][01] | [Как это работает?][02] | [RusOutdoor Maps][03] | [Скачать карты][04] | [API][05] |"
        
        let buttonsEn = "| [AnyGIS][01] | [How it works?][02] | [RusOutdoor Maps][03] | [Download][04] | [API][05] |"
        
        let header = isEnglish ? buttonsEn : buttonsRu
        
        let allPagesPostfix = isEnglish ? "_en" : "_ru"
        
        let indexPostfix = isEnglish ? "_en" : ""
        
        return """
        \(jekyllHeader)
        
        \(header)
        
        
        [01]: \(indexPage + indexPostfix)
        [02]: \(descriptionPage + allPagesPostfix)
        [03]: \(rusOutdoorPage + allPagesPostfix)
        [04]: \(downloadPage + allPagesPostfix)
        [05]: \(apiPage + allPagesPostfix)
        
        """
    }
    
    
    
    func getMarkdownMaplistIntro(appName: ClientAppList, isEnglish: Bool) -> String {
        
        let title = isEnglish ? "Download maps for" : "Скачать карты для"
        
        let name = appName.rawValue
        
        return """
        # \(title) \(name)
        
        """
    }
    
    
    
    func getMarkdownMaplistCategory(appName: ClientAppList, categoryName: String, fileGroupPrefix: String, isEnglish: Bool) -> String {
        
        let filenameWithoutSpaces = fileGroupPrefix.replacingOccurrences(of: " ", with: "%20")
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        
        
        var resultText = ""
        
        let label = isEnglish ? "Download all group files" : "Скачать всю группу"
        
        
        switch appName {
        case .Locus:
            let folderDownloaderUrl = patchTemplates.gitLocusActionInstallersFolder + langLabel + "_" + filenameWithoutSpaces + ".xml"
            
            resultText = """
            
            
            ### [\(categoryName)](\(folderDownloaderUrl) "\(label)")
            
            """
            
        case .Alpine:
            let folderDownloaderUrl = patchTemplates.anygisAlpineMapsFolder + langLabel + "_" + filenameWithoutSpaces + ".AQX"
            
            resultText = """
            
            
            ### [\(categoryName)](\(folderDownloaderUrl) "\(label)")
            
            """
            
        default:
            resultText = """
            
            
            ### \(categoryName)
            
            """
        }
        
        return resultText
    }
    
    
    
    func getMarkDownMaplistItem(appName: ClientAppList, name:String, fileName: String, isEnglish: Bool, hasPreview: Bool, dbMapName: String) -> String {
        
        var resultUrl = ""
        
         let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        switch appName {
        case .Locus:
            resultUrl = "=" + patchTemplates.gitLocusActionInstallersFolder + langLabel + "__" + fileName + ".xml"
        case .GuruMapsIOS:
            resultUrl = "=" + patchTemplates.gitMapsFolder + langLabel + fileName + ".ms"
        case .GuruMapsAndroid:
            resultUrl = "=" + patchTemplates.anygisGuruMapsFolder + langLabel + fileName + ".ms"
        case .Osmand:
            resultUrl = "=" + patchTemplates.gitOsmadMapsFolder + langLabel + fileName + ".sqlitedb"
        case .OsmandMetainfo:
            resultUrl = "=" + patchTemplates.gitOsmadMetainfoMapsFolderDownloader + langLabel + fileName + ".zip"
        case .Alpine:
            resultUrl = "=" + patchTemplates.anygisAlpineMapsFolder + langLabel + fileName + ".AQX"
        case .Desktop:
            resultUrl = patchTemplates.gitDesktopFilesFolder + langLabel + fileName + ".txt"
        default:
            break
        }
        
        
        let previewerIconCode = getPreviwIconCode(hasPreview: hasPreview, isEnglish: isEnglish, mapName: dbMapName)
        
        let label = isEnglish ? "Download this map" : "Скачать эту карту"
        
        
        return """
        \(previewerIconCode)  [\(name)](\(resultUrl) "\(label)")
        
        
        """
    }
    
    
    func getPreviwIconCode(hasPreview: Bool, isEnglish: Bool, mapName: String) -> String {
        
        
        if hasPreview {
            let iconUrl = patchTemplates.siteHost + "Web/Img/eye.png"
            let previewPageUrl = patchTemplates.serverHost + "preview/" + mapName
            let label = isEnglish ? "Preview map" : "Предпросмотр карты"
            
            return "<a href=\"\(previewPageUrl)\" target=\"_blank\" title=\"\(label)\" > <img src=\"\(iconUrl)\" /> </a>"
            
        } else {
            let iconUrl = patchTemplates.siteHost + "Web/Img/eyeNo.png"
            return "![](\(iconUrl))"
        }
        
    }
    
    
}
