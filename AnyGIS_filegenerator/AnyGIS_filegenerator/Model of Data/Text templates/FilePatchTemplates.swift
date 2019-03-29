//
//  UrlTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct FilePatchTemplates {
    
    // Main DB patch
    
    let dataBasePatch = "file://///Projects/GIS/AnyGIS%20server/AnyGIS_Server/base.sqlite"
    
    
    // Generating files folders in site
    
    let localPathToMarkdownPages = "file:////Projects/GIS/Online%20map%20sources/map-sources/Web/Html/Download/"
    let localPathToIcons = "file:////Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Icons/"
    let localPathToInstallers = "file:////Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Installers/"
    
    let localPathToLocusMapsFull = "file:////Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_full/"
    let localPathToLocusMapsShort = "file:////Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_short/"
    let localPathToGuruMapsFull = "file:////Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_full/"
    let localPathToGuruMapsShort = "file:////Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_short/"
    let localPathToOsmandMapsFull = "file:////Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Maps_full/"
    let localPathToOsmandMapsShort = "file:////Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Maps_short/"
    
    
    // Generating files folders in server
    
    let localPathToGuruMapsInServer = "file://///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/galileo/"
    let localPathToOruxMapsFullInServer = "file:////Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/orux_full/"
    let localPathToOruxMapsShortInServer = "file:////Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/orux_short/"
    
    
    
    
    // Links for download files dorectly from GitHub
    
    let gitLocusInstallersFolder = "https://github.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Installers/"
    let gitLocusIconsFolder = "https://github.com/nnngrach/AnyGIS_maps/raw/master/Locus_online_maps/Icons/"
    let gitLocusPagesFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Web/Html/Download/"
    
    let gitLocusMapsFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Maps_full/"
    let anygisGuruMapsFolder = "https://anygis.herokuapp.com/download/galileo/"
    
    
    let gitLocusFullMapsZip = "https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/nnngrach/AnyGIS_maps/tree/master/Locus_online_maps/Maps_full"
    let gitLocusShortMapsZip = "https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/nnngrach/AnyGIS_maps/tree/master/Locus_online_maps/Maps_short"
    
    let gitLocusActionInstallersFolder = "locus-actions://https/raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Installers/"
    let gitGuruActionInstallersFolder = "guru://open?path=https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Galileo_online_maps/Maps_full/"
    

}
