//
//  OsmandMapsTemplate.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 29/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Foundation

struct OsmandMapsTemplate {
    
    public let readAsScriptMethod = "beanshell"
    
    
    public func getUrlScript(url: String) -> String {
        var urlString = "return \"\(url)\";"
        if urlString.hasSuffix("\"\"") {
            urlString = String(urlString.dropLast())
        }
        
        return """
        String getTileUrl(int z, int x, int y) {
        \(urlString)
        }
        """
    }
    
    
    public func getServerPartScript(serverNames: String, serversCount: Int) -> String {
        return """
        
        public static String getServerName(int z, int x, int y) {
        static final String[] NUM_CHAR = { \(serverNames) };
        int i = ((x + y) % \(serversCount));
        return NUM_CHAR[i];
        }
        
        """
    }
    
    
    
    public func getWikiScript() -> String {
        return """
        
        public static String getServerName(int z, int x, int y) {
        return String.valueOf(x%4 + (y%4)*4);
        }
        
        """
    }
    
    
    
    public let getInvYScript = """

        public static String getInvYScript(int z, int x, int y) {
        return String.valueOf(Math.pow(2, z) - y - 1);
        }
        
        """
    
    
    
    public let getZPlus1 = """
        
        public static String getZPlus1(int z, int x, int y) {
        return String.valueOf(z + 1);
        }
        
        """
    
    
    public let getXDiv1024 = """
        
        public static String getXDiv1024(int z, int x, int y) {
        return String.valueOf(x / 1024);
        }
        
        """
    
    
    public let getYDiv1024 = """
        
        public static String getYDiv1024(int z, int x, int y) {
        return String.valueOf(y / 1024);
        }
        
        """
    
    
    public func getMetainfoText(url: String, serverNames: String, minZoom: Int64, maxZoom: Int64, isEllipsoid: Bool, isInvertedY: Bool, tileSize: String, timeSupported: String, cachingMinutes: String) -> String {
        
        var cachingTimeValue = ""
        
        if timeSupported == "yes" {
            cachingTimeValue = """
            [expiration_time_minutes]
            \(cachingMinutes)
            """
        }
        
        
        return """
        [url_template]
        \(url)
        [randoms]
        \(serverNames)
        [min_zoom]
        \(minZoom)
        [max_zoom]
        \(maxZoom)
        [ellipsoid]
        \(isEllipsoid)
        [inverted_y]
        \(isInvertedY)
        [tile_size]
        \(tileSize)
        [img_density]
        16
        [avg_img_size]
        32000
        [ext]
        .png
        \(cachingTimeValue)
        """
    }
    
}
