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
    
    let dataBasePatch = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/base.sqlite"
    
    
    // Generating files folders in site
    
    let localPathToMarkdownPages = "file:///Projects/GIS/Anygis_site/modernist-master/Web/Html/Download/"
    
    let localPathToIcons = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Icons"
    let localPathToInstallers = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Installers"
    let localPathToGeoJson = "file:///Projects/GIS/Online%20map%20sources/map-sources/GeoJson"
    
    
    let localPathToLocusMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Zip/"
    let localPathToLocusMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_full"
    let localPathToLocusMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_short"
    
    
    let localPathToGuruMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Zip/"
    let localPathToGuruMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_full"
    let localPathToGuruMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_short"
    
    let localPathToOsmandMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Zip/"
    let localPathToOsmandMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Maps_full"
    let localPathToOsmandMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Maps_short"
    
    let localPathToOsmandMetainfoZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Zip/"
    let localPathToOsmandMetainfoFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Maps_full"
    let localPathToOsmandMetainfoShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Maps_short"
    
    let localPathToOruxMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Orux_online_maps/Maps_full"
    let localPathToOruxMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Orux_online_maps/Maps_short"
    
    let localPathToAlpineMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Zip/"
    let localPathToAlpineMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Maps_full"
    let localPathToAlpineMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Maps_short"
    
    
    // Generating files folders in server
    
    let localPathToGuruMapsInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/galileo"
    let localPathToOruxMapsFullInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/orux_full"
    let localPathToOruxMapsShortInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/orux_short"
    let localPathToAlpineMapsInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/alpine"
    
    
    
    
    // Links for download files dorectly from GitHub
    
    let gitLocusInstallersFolder = "https://github.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Installers/"
    let gitLocusIconsFolder = "https://github.com/nnngrach/AnyGIS_maps/raw/master/Locus_online_maps/Icons"
    let gitLocusPagesFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Web/Html/Download/"
    
    let gitLocusMapsFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Maps_full"
    let gitOsmadMapsFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Osmand_online_maps/Sqlitedb/Maps_full"
    let gitOsmadMetainfoMapsFolder = "https://github.com/nnngrach/AnyGIS_maps/tree/master/Osmand_online_maps/Metainfo/Maps_full"
    let gitOsmadMetainfoMapsFolderDownloader = "https://github.com/nnngrach/AnyGIS_maps/raw/master/Osmand_online_maps/Metainfo/Maps_full"
    let gitAlpineMapsFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/AlpineQuest_online_maps/Maps_full"
    
    let anygisGuruMapsFolder = "https://anygis.ru/server/download/galileo"
    let anygisAlpineMapsFolder = "https://anygis.ru/server/download/alpine"
    //let anygisGuruMapsFolder = "https://anygis.herokuapp.com/download/galileo"
    //let anygisAlpineMapsFolder = "https://anygis.herokuapp.com/download/alpine"

    
    
    let gitDownloaderApi = "https://minhaskamal.github.io/DownGit/#/home?url="
    let gitLocusFullMapsZip = "https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/nnngrach/AnyGIS_maps/tree/master/Locus_online_maps/Maps_full"
    let gitLocusShortMapsZip = "https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/nnngrach/AnyGIS_maps/tree/master/Locus_online_maps/Maps_short"
    
    let gitLocusActionInstallersFolder = "locus-actions://https/raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Installers"
    let gitMapsFolder = "guru://open?path=https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Galileo_online_maps/Maps_full"
    
    
    
    let rusLanguageSubfolder = "_ru/"
    let engLanguageSubfolder = "_en/"
}
