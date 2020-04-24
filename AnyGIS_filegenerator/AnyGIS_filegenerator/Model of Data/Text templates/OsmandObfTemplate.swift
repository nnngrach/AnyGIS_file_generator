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
      "version" : 1,
      "items" : [
        {
          "type" : "PLUGIN",
          "pluginId" : "ru.anygis.plugin",
          "version" : 2,
          "icon" : {"" : "@plugin-id.png"},
          "image" : {"" : "@plugin-image.webp"},
          "name" : {
            "" : "Collection of online maps",
            "ru" : "Коллекция онлайн-карт"
          },
          "description" : {
            "" : "This package is a collection of online map sources of various types: satellite, tourist, historical, and many others. \\nIf you notice any problems, please report them to the telegram chat <a href=\\"https://t.me/anygis\\">@anygis</a> or email <a href=\\"mailto:anygis@bk.ru\\">anygis@bk.ru</a>.",
            "ru" : "Сборник с источниками растровых онлайн-карт разных типов: спутниковых, туристических, исторических и многих других. \\nО замеченных неисправностях сообщайте в telegram-чат  <a href=\\"https://t.me/anygis\\">@anygis</a> или на электронную почту <a href=\\"mailto:anygis@bk.ru\\">anygis@bk.ru</a>."
          }
        },


        {
          "type" : "DOWNLOADS",
          "pluginId" : "ru.anygis.plugin",
          "items" : [

            {
              "path" : "anygis",
              "name" : {"" : "AnyGis Online Maps"},
              "icon" : {"" : "ic_world_globe_dark"},
              "header-color" : "#002E64",

              "description" : {
                "text" : {
                  "" : "This package is a collection of online map sources of various types: satellite, tourist, historical, and many others. \\nIf you notice any problems, please report them to the telegram chat.",
                  "ru" : "Сборник с источниками растровых онлайн-карт разных типов: спутниковых, туристических, исторических и многих других. \\nО замеченных неисправностях сообщайте в telegram-чат."
                },
                "button" : [{
                  "" : "Telegram chat",
                  "url" : "https:\\/\\/t.me\\/anygis"
                }]
              }
            },
            {$mapCategories}
          ]
        },


        {
          "type" : "RESOURCES",
          "pluginId" : "ru.anygis.plugin",
          "file" : "res"
        }
      ]
    }
    """


    
    
    let oneMapCategory =
    """



            {
               "scope-id" : "online-maps",
               "path" : "anygis/{$category}",
               "header-color" : "#002E64",
               "name" : {
                 "" : "{$categoryLabelEn}",
                 "ru" : "{$categoryLabelRu}"
               },
               "icon" : { "" : "ic_world_globe_dark" },
               "items" : [
                  {$mapItems}
               ]
            },
    """
    
    
    
//    "filename":{
//        "":"{$filenameEn}",
//        "ru":"{$filenameRu}"
//    },

    
    let oneMapItem =
    """


                    {
                      "name" : {
                        "" : "{$mapLabelEn}",
                        "ru" : "{$mapLabelRu}"
                      },
                      "filename" : "{$filenameEn}",
                      "type" : "{$fileFormat}",
                      "date" : "{$date}",
                      "timestamp" : {$timestamp},
                      "containerSize" : 2292857,
                      "contentSize" : 3696925,
                      "description" : {
                        "text": {
                          "": "{$descriptionEn}",
                          "ru": "{$descriptionRu}"
                        },
                        "image": ["{$imagePreview}"]
                      },
                      "downloadurl": "{$downloadurl}",
                      "firstsubname" : {
                          "" : "{$firstsubnameEn}",
                          "ru" : "{$firstsubnameRu}"
                      },
                      "secondsubname" : {
                          "" : "{$secondsubnameEn}",
                          "ru" : "{$secondsubnameRu}"
                      }
                    },
    """
    
    
    public func getDescriptionEn(_ mapClientLine: MapsClientData, _ mapServerLine: MapsServerData, _ date: String) -> String {
        let n = "<br />"
        return
            "Zoom min: \(mapServerLine.zoomMin)" + n +
            "Zoom max: \(mapServerLine.zoomMax)" + n +
            "Countries: \(mapClientLine.countries)" + n +
            "Copyright: \(mapClientLine.copyright)" + n +
            "Last config update: \(date)"
    }
    
}
