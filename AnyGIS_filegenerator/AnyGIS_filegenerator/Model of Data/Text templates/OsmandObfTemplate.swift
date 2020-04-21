//
//  OsmandObfTemplate.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 21.04.2020.
//  Copyright © 2020 Nnngrach. All rights reserved.
//

import Foundation

class OsmandOsfTemplate {
    
    let wholePluginTemplate =
    """
    {
       "version":1,
       "items":[
          {
             "type":"PLUGIN",
             "pluginId":"ru.anygis.plugin",
             "version":2,
             "icon":{
                "":"@plugin-id.png"
             },
             "image":{
                "":"@plugin-image.webp"
             },
             "name":{
                "":"Collection of online maps",
                "ru":"Коллекция онлайн-карт"
             },
             "description":{
                "":"This package is a collection of online map sources of various types: satellite, tourist, historical, and many others. \nIf you notice any problems, please report them to the telegram chat <a href=\"https://t.me/anygis\">@anygis</a> or email anygis@bk.ru.",
                "ru":"Сборник с источниками растровых онлайн-карт разных типов: спутниковых, туристических, исторических и многих других. \nО замеченных неисправностях сообщайте в telegram-чат  <a href=\"https://t.me/anygis\">@anygis</a> или на электронную почту anygis@bk.ru."
             }
          },

          {
             "type":"DOWNLOADS",
             "pluginId":"ru.anygis.plugin",
             "items":[

                {
                   "path":"anygis",
                   "name":{
                      "":"AnyGis Online Maps"
                   },
                   "icon":{
                      "":"ic_world_globe_dark"
                   },
                   "header":{
                      "":"This package is a collection of online map sources of various types: satellite, tourist, historical, and many others. \nIf you notice any problems, please report them to the telegram chat <a href=\"https://t.me/anygis\">@anygis</a> or email anygis@bk.ru."
                   },
                   "header-button":{
                      "url":"https://t.me/anygis",
                      "":"Telegram chat"
                   }
                },

                {$mapCategories}

             ]

          },
          {
             "type":"RESOURCES",
             "pluginId":"ru.anygis.plugin",
             "file":"res"
          }
       ]
    }
    """
    
    
    
    let oneMapCategory =
    """

    {
       "scope-id":"online-maps",
       "path":"anygis/{$category}",
       "header-color":"#002E64",
       "name":{
          "":"{$categoryLabel}"
       },
       "icon":{
          "":"ic_world_globe_dark"
       },
       "items":[

          {$mapItems}

       ]
    },
    """
    
    //"type":"sqlite"
    //"filename":"Strava_Ride_Hd.sqlitedb",
    
    let oneMapItem =
    """

    {
       "name":{
          "":"{$mapLabel}"
       },
       "containerSize":2292857,
       "type":"{$fileFormat}",
       "contentSize":2292857,
       "timestamp":{$timestamp},
       "description":"",
       "image-description-url":[

       ],
       "filename":"{$filename}",
       "firstsubname":{
          "":"World"
       },
       "secondsubname":{
          "":"FREE"
       },
       "downloadurl":"{$downloadurl}"
    },
    """
    
}
