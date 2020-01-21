//
//  LocusTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct LocusInstallersTemplates {
    
    private let patchTemplates = FilePathTemplates()
    private let webPagesTemplates = WebPageTemplates()
    private let descriptionTemplates = DecsriptionTemplate()
    
    
    //MARK: Templates for Locus actions XLM installer
    
    func getIstallerFileIntro() -> String {
        return """
        <?xml version="1.0" encoding="utf-8"?>
        
        \(descriptionTemplates.getDescription(appName: .Locus))
        
        
        <locusActions>
        
        """
    }
    
    
    
    func getIstallerFileItem(fileName: String, isIcon: Bool, isEnglish: Bool, isUninstaller: Bool) -> String {
        
        let patch = isIcon ? patchTemplates.gitLocusIconsFolder : patchTemplates.gitLocusMapsFolder
        let langLabel = isEnglish ? patchTemplates.engLanguageSubfolder : patchTemplates.rusLanguageSubfolder
        let fileType = isIcon ? ".png" : ".xml"
        let filenameWithoutSpaces = fileName.replacingOccurrences(of: " ", with: "%20")
        
        let instalationPath = "/mapsOnline/custom/\(fileName + fileType)"
        
        var downloadPath = ""
        
        if isUninstaller {
            downloadPath = patchTemplates.gitLocusEmptyMap
        } else {
            downloadPath = "\(patch + langLabel + filenameWithoutSpaces + fileType)"
        }
        
        return """
        
        <download>
        <source>
        <![CDATA[\(downloadPath)]]>
        </source>
        <dest>
        <![CDATA[\(instalationPath)]]>
        </dest>
        </download>
        
        """
    }
    
    
    
    func getIstallerFileOutro() -> String {
        return """
        
        </locusActions>
        """
    }
    

    
}
