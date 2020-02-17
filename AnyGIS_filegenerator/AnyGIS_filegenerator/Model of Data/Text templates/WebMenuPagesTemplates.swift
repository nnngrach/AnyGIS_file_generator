//
//  WebMenuPagesTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 11/02/2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

struct WebMenuPageTemplates {
    
    private let patchTemplates = FilePathTemplates()
    
    
    private let siteHeader = "AnyGIS"
    private let siteDescription = "Online maps pack"
    private let defaultSiteLang = "en-US"
    private let cssPath = "/assets/css/style.css?v="
    private let jsPath = "/assets/js/scale.fix.js"
    
    
        
    
    private let contentStub = "{{ content }}"
    private let langStub = "{{ site.lang | default: \"en-US\" }}"
    private let siteHeaderStub = "{{ site.title | default: site.github.repository_name }}"
    private let siteDescriptionStub = "{{ site.description | default: site.github.project_tagline }}"
    private let cssStub = "{{ '/assets/css/style.css?v=' | append: site.github.build_revision | relative_url }}"
    private let jsStub = "{{ '/assets/js/scale.fix.js' | relative_url }}"
    private let stubsForErasing = ["{% seo %}", "{% if site.description or site.github.project_tagline %}" , "{% endif %}", "{% unless site.description or site.github.project_tagline %} class=\"without-description\" {% endunless %}"]
    

        
    
    public func fillStubsInHtmlPageTemplate(_ template: String) -> (intro: String, outro: String) {
            
        let textPreparedForSplitting = template.replacingOccurrences(of: contentStub, with: "±")
        let splittedDocumentPatrs = textPreparedForSplitting.split(separator: "±")
        
        var introPart = String(splittedDocumentPatrs[0])
        let outroPart = String(splittedDocumentPatrs[1])
        
        introPart = introPart.replacingOccurrences(of: langStub, with: defaultSiteLang)
        introPart = introPart.replacingOccurrences(of: cssStub, with: cssPath)
        introPart = introPart.replacingOccurrences(of: jsStub, with: jsPath)
        introPart = introPart.replacingOccurrences(of: siteHeaderStub, with: siteHeader)
        introPart = introPart.replacingOccurrences(of: siteDescriptionStub, with: siteDescription)
    
        for stub in stubsForErasing {
            introPart = introPart.replacingOccurrences(of: stub, with: "")
        }
        
        return (intro: introPart, outro: outroPart)
    }
    
    
    
    
    public func getHeaderLabel(isEnglish: Bool, appName: ClientAppList) -> String {
        
        let title = isEnglish ? "Download maps for" : "Скачать карты для"
        let name = appName.rawValue
        return "<h1>" + title + " " + name + "</h1>"
    }
    
    
    
    
    public func getHeaderMenu(isEnglish: Bool) -> String {
        
        if isEnglish {
            return """
            <table>
              <tbody>
                <tr>
                  <td><a href="/index_en">Main page</a></td>
                  <td><a href="/Web/Html/Articles_en">Articles</a></td>
                  <td><a href="/Web/Html/DownloadPage_en">Download maps</a></td>
                  <td><a href="https://www.donationalerts.com/r/nnngrach">Donate</a></td>
                </tr>
              </tbody>
            </table>
            
            
            """
        } else {
            return """
            <table>
              <tbody>
                <tr>
                  <td><a href="/index">На главную</a></td>
                  <td><a href="/Web/Html/Articles_ru">Полезные статьи</a></td>
                  <td><a href="/Web/Html/DownloadPage_ru">Скачать карты</a></td>
                  <td><a href="https://www.donationalerts.com/r/nnngrach">Поддержать проект</a></td>
                </tr>
              </tbody>
            </table>
            
            
            
            """
        }
    }
    
    public func getMenuIntro() -> String {
        return """
        <div class="nav">
          <div class="parent-groups">
        
        """
    }
    
    public func getMenuOutro() -> String {
        return """
        
          </div>
        </div>
        """
    }
    
    
    public func getFirstLevelFolderIntro(folderName: String, fullFolderPathEn: String, folderFilePrefix: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let iconName = fullFolderPathEn.replacingOccurrences(of: " ", with: "%20")
        let iconPath = "/Web/Img/Icons_en/" + iconName + ".png"
        
        let folderDowlnloadIcon = getDownloadFolderIcon(fullFolderPathEn: folderFilePrefix, isEnglish: isEnglish, appName: appName)
        
        
        return """
        <div class="item">
          <input type="checkbox" id="\(fullFolderPathEn)"/>
          <img src="/Web/Img/arrow_menu.png" class="arrow">
          <label for="\(fullFolderPathEn)" class="accordeon">
            <img src="\(iconPath)" class="menu_icon"/>
            \(folderDowlnloadIcon)
            \(folderName)
          </label>
          
        
          <ul class="accordeon">
        
        """
    }
    

    
    
    public func getFirstLevelFolderOutro() -> String {
        return """
          </ul>
        </div>
        
        """
    }
    
    
    public func getSubLevelFolderIntro(folderName: String, fullFolderPathEn: String, folderFilePrefix: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        let folderDowlnloadIcon = getDownloadFolderIcon(fullFolderPathEn: folderFilePrefix, isEnglish: isEnglish, appName: appName)
        
        return """
        <li class="accordeon">
            <div class="item">
            <input type="checkbox" id="\(fullFolderPathEn)"/>
            <img src="/Web/Img/arrow_menu.png" class="arrow">
            <label for="\(fullFolderPathEn)">
                \(folderDowlnloadIcon)
                \(folderName)
            </label>
        
        <ul class="accordeon">
        
        """
    }
    
    
    public func getSubLevelFolderOutro() -> String {
        return """
            </ul>
          </div>
        </li>
        
        """
    }
    
    public func getMapItem(isEnglish: Bool, appName: ClientAppList, mapObject: MenuMapItem) -> String {
        
        let mapName = isEnglish ? mapObject.nameEn : mapObject.name
        
        let downloadSplash = isEnglish ? "Download this map" : "Скачать эту карту"
        
        let previewIconCode = getPrewiewIconCode(hasPreview: mapObject.hasPreview, isEnglish: isEnglish, anygisMapName: mapObject.anygisMapName)
        
        let fileName = "=" + mapObject.fileGroupPrefix + "=" + mapObject.fileName
        
        let downloadUrl = getMapDownloadUrl(appName: appName, fileName: fileName, isEnglish: isEnglish)
        
        return """
        <li class="accordeon">
          \(previewIconCode)
          <a
            href="\(downloadUrl)"
            title="\(downloadSplash)">
            \(mapName)
          </a>
        </li>
        
        """
    }
    
    

    
    private func getDownloadFolderIcon(fullFolderPathEn: String, isEnglish: Bool, appName: ClientAppList) -> String {
        
        var result = ""
        
        if appName == ClientAppList.Alpine {
            
            let downloadLink = getFolderDownloadUrl(appName: appName, folderName: fullFolderPathEn, isEnglish: isEnglish)
            
            let message = isEnglish ? "Download folder" : "Скачать всю папку"
            
            result = """
            <a
              href="\(downloadLink)"
              target="_blank" title="\(message)">
              <img src="/Web/Img/folder_download_gray.png" class="download_folder_icon"/>
            </a>
            """
        }
        
        return result
    }
    
    
    
    
    private func getMapDownloadUrl(appName: ClientAppList, fileName: String, isEnglish: Bool) -> String {
        
        var resultUrl = ""
        
         let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        switch appName {
        case .Locus:
            resultUrl = patchTemplates.gitLocusActionInstallersFolder + langLabel + "__" + fileName + ".xml"
        case .GuruMapsIOS:
            resultUrl = patchTemplates.gitMapsFolder + langLabel + fileName + ".ms"
        case .GuruMapsAndroid:
            resultUrl = patchTemplates.anygisGuruMapsFolder + langLabel + fileName + ".ms"
        case .Osmand:
            resultUrl = patchTemplates.gitOsmadMapsFolder + langLabel + fileName + ".sqlitedb"
        case .OsmandMetainfo:
            resultUrl = patchTemplates.gitOsmadMetainfoMapsFolderDownloader + langLabel + fileName + ".zip"
        case .Alpine:
            resultUrl = patchTemplates.anygisAlpineMapsFolder + langLabel + fileName + ".AQX"
        case .Desktop:
            resultUrl = patchTemplates.gitDesktopFilesFolder + langLabel + fileName + ".txt"
        default:
            break
        }
        
        return resultUrl
    }
    
    
    
    func getFolderDownloadUrl(appName: ClientAppList, folderName: String, isEnglish: Bool) -> String {
        
        var resultUrl = ""
        
         let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        
        switch appName {
        case .Locus:
            resultUrl = patchTemplates.gitLocusActionInstallersFolder + langLabel + "__" + folderName + ".xml"
        case .Alpine:
            resultUrl = patchTemplates.anygisAlpineMapsFolder + langLabel + "=" + folderName + ".AQX"
        default:
            break
        }
        
        return resultUrl
    }
    
    
    
    
    private func getPrewiewIconCode(hasPreview: Bool, isEnglish: Bool, anygisMapName: String) -> String {
        
        if hasPreview {
            let previewSplash = isEnglish ? "Preview map" : "Предпросмотр карты"
            
            return """
            <a
              href="https://anygis.ru/api/v1/preview/\(anygisMapName)"
              target="_blank" title="\(previewSplash)">
              <img src="/Web/Img/eye_gray.png" class="eye_icon"/>
            </a>
            """
            
        } else {
            return """
            <img src="/Web/Img/eyeNo_gray.png" class="eye_icon"/>
            """
        }
    }
    
}
