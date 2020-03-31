//
//  UrlTemplates.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 27/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct FilePathTemplates {
    
    let siteHost = "https://anygis.ru/"
    //let siteHost = "http://localhost:8080/"
    let serverHost = "https://anygis.ru/api/v1/"
    let serverHostHttp = "http://anygis.ru/api/v1/"
    
    
    // Main DB patch
    
    let dataBasePatch = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/base.sqlite"
    
    
    
    // Generating files folders in site
    
    let localPathToMarkdownPages = "file:///Projects/GIS/Anygis_site/modernist-master/Web/Html/Download/"
    
    let localPathToJekillHtmlTemplate = "file:///Projects/GIS/Anygis_site/modernist-master/_layouts/default.html"
    
    
    
    
    
    
    let localPathToLocusIcons = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Icons"
    let localPathToLocusInstallers = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Installers"
    let localPathToGeoJson = "file:///Projects/GIS/Online%20map%20sources/map-sources/GeoJson"
    
    
    let localPathToLocusMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Zip/"
    let localPathToLocusMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_full"
    let localPathToLocusMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_short"
    let localPathToLocusMapsPrivate = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/Locus"
    
    
    let localPathToGuruMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Zip/"
    let localPathToGuruMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_full"
    let localPathToGuruMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_short"
    let localPathToGuruMapsPrivate = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/GuruMaps"
    
    let localPathToOsmandMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Zip/"
    let localPathToOsmandMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Maps_full"
    let localPathToOsmandMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Maps_short"
    let localPathToOsmandMapsPrivate = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/Osmand_sqlitedb"
    
    let localPathToOsmandMetainfoZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Zip/"
    let localPathToOsmandMetainfoFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Maps_full"
    let localPathToOsmandMetainfoShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Maps_short"
    let localPathToOsmandMetainfoPrivate = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/Osmand_metainfo"
    
    let localPathToOruxMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/Orux_online_maps/Maps_full"
    let localPathToOruxMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/Orux_online_maps/Maps_short"
    let localPathToOruxMapsPrivate = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/Orux"
    
    let localPathToAlpineMapsZip = "file:///Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Zip/"
    let localPathToAlpineMapsFull = "file:///Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Maps_full"
    let localPathToAlpineMapsShort = "file:///Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Maps_short"
    let localPathToAlpineMapsPrivate = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/AlpineQuest"
    
    
    let localPathToDesktopMaps = "file:///Projects/GIS/Online%20map%20sources/map-sources/Desktop/"
    let localPathToDesktopMapsPrivate = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/Desktop"
    
    let localPathToPrivateSetFolder = "file:///Projects/GIS/Online%20map%20sources%20deleted/Files/"
    let localPathToPrivateSetZip = "file:///Projects/GIS/Online%20map%20sources%20deleted/Zip/"
    
    let localPathToSasPlanetFolder = "file:///Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Maps/"
    
    let localPathToSasPlanetMaps = "file:///Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Maps/anygis/"
    
    let localPathToSasPlanetIcons = "file:///Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Icons/"
    
     let localPathToSasPlanetTemplates = "file:///Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Templates/"
    
    let localPathToSasPlanetInGitFolder = "file:///Projects/GIS/SAS/sas.plus.maps/anygis/"
    
    
    
    
    
    // Generating files folders in server
    
    let localPathToGuruMapsInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/galileo"
    let localPathToOruxMapsFullInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/orux_full"
    let localPathToOruxMapsShortInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/orux_short"
    let localPathToAlpineMapsInServer = "file:///Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/alpine"
    
    
    
    
    
    // Links for download files dorectly from GitHub
    
    let gitLocusInstallersFolder = "https://github.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Installers/"
    let gitLocusIconsFolder = "https://github.com/nnngrach/AnyGIS_maps/raw/master/Locus_online_maps/Icons"
    let gitLocusIconsFolderPreviewing = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Icons"
    let gitLocusPagesFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Web/Html/Download/"
    
    let gitLocusMapsFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Maps_full"
    let gitLocusEmptyMap = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/empty.xml"
    let gitOsmadMapsFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Osmand_online_maps/Sqlitedb/Maps_full"
    let gitOsmadMetainfoMapsFolder = "https://github.com/nnngrach/AnyGIS_maps/tree/master/Osmand_online_maps/Metainfo/Maps_full"
    let gitOsmadMetainfoMapsFolderDownloader = "https://github.com/nnngrach/AnyGIS_maps/raw/master/Osmand_online_maps/Metainfo/Maps_full"
    let gitAlpineMapsFolder = "https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/AlpineQuest_online_maps/Maps_full"
    let gitDesktopFilesFolder = "https://github.com/nnngrach/AnyGIS_maps/blob/master/Desktop/"
    
    let anygisGuruMapsFolder = "https://anygis.ru/api/v1/download/galileo"
    let anygisAlpineMapsFolder = "https://anygis.ru/api/v1/download/alpine"
    
    
    
    let gitDownloaderApi = "https://minhaskamal.github.io/DownGit/#/home?url="
    let gitLocusFullMapsZip = "https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/nnngrach/AnyGIS_maps/tree/master/Locus_online_maps/Maps_full"
    let gitLocusShortMapsZip = "https://minhaskamal.github.io/DownGit/#/home?url=https://github.com/nnngrach/AnyGIS_maps/tree/master/Locus_online_maps/Maps_short"
    
    let gitLocusActionInstallersFolder = "locus-actions://https/raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Locus_online_maps/Installers"
    let gitMapsFolder = "guru://open?path=https://raw.githubusercontent.com/nnngrach/AnyGIS_maps/master/Galileo_online_maps/Maps_full"
    
    
    
    let rusLanguageSubfolder = "_ru/"
    let engLanguageSubfolder = "_en/"
    let groupInOneFileSubfolder = "_folders"
}
