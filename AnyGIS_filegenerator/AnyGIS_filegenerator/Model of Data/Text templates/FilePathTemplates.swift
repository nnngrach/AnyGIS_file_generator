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
    
    let dataBasePatch = "file:////Users/Shared/Old_catalog/Projects/GIS/AnyGIS%20server/AnyGIS_Server/base.sqlite"
    
    
    
    // Generating files folders in site
    
    let localPathToMarkdownPages = "file:////Users/Shared/Old_catalog/Projects/GIS/Anygis_site/modernist-master/Web/Html/Download/"
    
    let localPathToJekillHtmlTemplate = "file:////Users/Shared/Old_catalog/Projects/GIS/Anygis_site/modernist-master/_layouts/default.html"
    
    
    
    
    
    
    let localPathToLocusIcons = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Icons"
    let localPathToLocusInstallers = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Installers"
    let localPathToGeoJson = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/GeoJson"
    
    
    let localPathToLocusMapsZip = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Zip/"
    let localPathToLocusMapsFull = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_full"
    let localPathToLocusMapsShort = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Locus_online_maps/Maps_short"
    let localPathToLocusMapsPrivate = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/Locus"
    
    
    let localPathToGuruMapsZip = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Zip/"
    let localPathToGuruMapsFull = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_full"
    let localPathToGuruMapsShort = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Galileo_online_maps/Maps_short"
    let localPathToGuruMapsPrivate = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/GuruMaps"
    
    let localPathToOsmandMapsZip = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Zip/"
    let localPathToOsmandMapsFull = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Maps_full"
    let localPathToOsmandMapsShort = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Sqlitedb/Maps_short"
    let localPathToOsmandMapsPrivate = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/Osmand_sqlitedb"
    
    let localPathToOsmandMetainfoZip = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Zip/"
    let localPathToOsmandMetainfoFull = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Maps_full"
    let localPathToOsmandMetainfoShort = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Metainfo/Maps_short"
    let localPathToOsmandMetainfoPrivate = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/Osmand_metainfo"
    
    let localPathToOsmandOsf = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Osmand_online_maps/Osf/Maps_full"
    
    let localPathToOruxMapsFull = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Orux_online_maps/Maps_full"
    let localPathToOruxMapsShort = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Orux_online_maps/Maps_short"
    let localPathToOruxMapsPrivate = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/Orux"
    
    let localPathToAlpineMapsZip = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Zip/"
    let localPathToAlpineMapsFull = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Maps_full"
    let localPathToAlpineMapsShort = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/AlpineQuest_online_maps/Maps_short"
    let localPathToAlpineMapsPrivate = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/AlpineQuest"
    
    
    let localPathToDesktopMaps = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/Desktop/"
    let localPathToDesktopMapsPrivate = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/Desktop"
    
    let localPathToPrivateSetFolder = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Files/"
    let localPathToPrivateSetZip = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources%20deleted/Zip/"
    
    let localPathToSasPlanetFolder = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Maps/"
    
    let localPathToSasPlanetMaps = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Maps/anygis/"
    
    let localPathToSasPlanetIcons = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Icons/"
    
     let localPathToSasPlanetTemplates = "file:////Users/Shared/Old_catalog/Projects/GIS/Online%20map%20sources/map-sources/SasPlanet/Templates/"
    
    let localPathToSasPlanetInGitFolder = "file:////Users/Shared/Old_catalog/Projects/GIS/SAS/sas.plus.maps/anygis/"
    
    
    
    
    
    // Generating files folders in server
    
    let localPathToGuruMapsInServer = "file:////Users/Shared/Old_catalog/Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/galileo"
    let localPathToOruxMapsFullInServer = "file:////Users/Shared/Old_catalog/Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/orux_full"
    let localPathToOruxMapsShortInServer = "file:////Users/Shared/Old_catalog/Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/orux_short"
    let localPathToAlpineMapsInServer = "file:////Users/Shared/Old_catalog/Projects/GIS/AnyGIS%20server/AnyGIS_Server/Public/server/alpine"
    
    
    
    
    
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
