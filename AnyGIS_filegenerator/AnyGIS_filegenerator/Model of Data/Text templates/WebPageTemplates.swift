//
//  WebPagesTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct WebPageTemplates {
    
    private let patchTemplates = FilePatchTemplates()
    
    
    //MARK: Header links
    
    let indexPage = "https://nnngrach.github.io/AnyGIS_maps/index"
    let descriptionPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/Description"
    let rusOutdoorPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/RusOutdoor"
    let downloadPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/DownloadPage"
    let locusPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/Locus"
    let guruPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/Galileo"
    let oruxPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/Orux"
    let osmandPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/Osmand"
    let apiPage = "https://nnngrach.github.io/AnyGIS_maps/Web/Html/Api"
    
    let anygisMapUrl = "https://anygis.herokuapp.com/{mapName}/{x}/{y}/{z}"
    let anygisMapUrlHttp = "http://anygis.herokuapp.com/{mapName}/{x}/{y}/{z}"
    
    let email = "anygis@bk.ru"
    
    
    
    //MARK: Templates for Markdown page generation
    
    func getMarkdownHeader(isEnglish: Bool) -> String {
        
        let buttonsRu = "| [AnyGIS][01] | [Как это работает?][02] | [RusOutdoor Maps][03] | [Скачать карты][04] | [API][05] |"
        
        let buttonsEn = "| [AnyGIS][01] | [How it works?][02] | [RusOutdoor Maps][03] | [Download][04] | [API][05] |"
        
        let header = isEnglish ? buttonsEn : buttonsRu
        
        let allPagesPostfix = isEnglish ? "_en" : "_ru"
        
        let indexPostfix = isEnglish ? "_en" : ""
        
        return """
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
    
    
    
    func getMarkdownMaplistCategory(appName: ClientAppList, categoryName: String, fileName: String, isEnglish: Bool) -> String {
        
        let filenameWithoutSpaces = fileName.replacingOccurrences(of: " ", with: "%20")
        
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        let locusFolderDownloaderUrl = patchTemplates.gitLocusActionInstallersFolder + langLabel + "_" + filenameWithoutSpaces + ".xml"
        
        var resultText = ""
        
        let label = isEnglish ? "Download all group files" : "Скачать всю группу"
        
        
        switch appName {
        case .Locus:
            resultText = """
            
            
            ### [\(categoryName)](\(locusFolderDownloaderUrl) "\(label)")
            
            """
            
        default:
            resultText = """
            
            
            ### \(categoryName)
            
            """
        }
        
        return resultText
    }
    
    
    
    func getMarkDownMaplistItem(appName: ClientAppList, name:String, fileName: String, isEnglish: Bool) -> String {
        
        var resultUrl = ""
        
         let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        switch appName {
        case .Locus:
            resultUrl = patchTemplates.gitLocusActionInstallersFolder + langLabel + "__" + fileName + ".xml"
        case .GuruMapsIOS:
            resultUrl = patchTemplates.gitGuruActionInstallersFolder + langLabel + fileName + ".ms"
        case .GuruMapsAndroid:
            resultUrl = patchTemplates.anygisGuruMapsFolder + langLabel + fileName + ".ms"
        case .Osmand:
            resultUrl = patchTemplates.gitOsmadMapsFolder + langLabel + fileName + ".sqlitedb"
        default:
            break
        }
        
        let label = isEnglish ? "Download this map" : "Скачать эту карту"
        
        return """
        [\(name)](\(resultUrl) "\(label)")
        
        
        """
    }
    
    
}
