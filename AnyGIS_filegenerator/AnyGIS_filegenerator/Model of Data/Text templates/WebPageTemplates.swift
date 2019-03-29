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
    
    func getMarkdownHeader() -> String {
        return """
        | [AnyGIS][01] | [Как это работает?][02] | [RusOutdoor Maps][03] | [Скачать карты][04] | [API][05] |
        
        
        [01]: \(indexPage)
        [02]: \(descriptionPage)
        [03]: \(rusOutdoorPage)
        [04]: \(downloadPage)
        [05]: \(apiPage)
        
        """
    }
    
    
    
    func getMarkdownMaplistIntro(appName: ClientAppList) -> String {
        
        let name = appName.rawValue
        
        return """
        # Скачать карты для \(name)
        
        """
    }
    
    
    
    func getMarkdownMaplistCategory(appName: ClientAppList, categoryName: String, fileName: String) -> String {
        
        let filenameWithoutSpaces = fileName.replacingOccurrences(of: " ", with: "%20")
        
        let locusFolderDownloaderUrl = patchTemplates.gitLocusActionInstallersFolder + "_" + filenameWithoutSpaces + ".xml"
        
        var resultText = ""
        
        switch appName {
        case .Locus:
            resultText = """
            
            
            ### [\(categoryName)](\(locusFolderDownloaderUrl) "Скачать всю группу")
            
            """
            
        default:
            resultText = """
            
            
            ### \(categoryName)
            
            """
        }
        
        return resultText
    }
    
    
    
    func getMarkDownMaplistItem(appName: ClientAppList, name:String, fileName: String) -> String {
        
        var resultUrl = ""
        
        switch appName {
        case .Locus:
            resultUrl = patchTemplates.gitLocusActionInstallersFolder + "__" + fileName + ".xml"
        case .GuruMapsIOS:
            resultUrl = patchTemplates.gitGuruActionInstallersFolder + fileName + ".ms"
        case .GuruMapsAndroid:
            resultUrl = patchTemplates.anygisGuruMapsFolder + fileName + ".ms"
        default:
            break
        }
        
        return """
        [\(name)](\(resultUrl) "Скачать эту карту")
        
        
        """
    }
    
    
}
