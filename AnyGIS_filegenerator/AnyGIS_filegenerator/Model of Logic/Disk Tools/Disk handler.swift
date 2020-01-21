//
//  DiskHandler.swift
//  AnyGIS_ServerPackageDescription
//
//  Created by HR_book on 24/02/2019.
//

import Foundation

class DiskHandler {
    
    
    public func createFile(patch: String, content: String, isWithBOM: Bool) {
        
        let bomMarker = "\u{FEFF}"
        
        let fullContent = isWithBOM ? (bomMarker + content) : content

        
        let patchWithoutSpaces = patch.replacingOccurrences(of: " ", with: "")

        let pathAsUrl = URL(string: patchWithoutSpaces)!
        
        
        do {
            try fullContent.write(to: pathAsUrl, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
    
    
    
    
    public func createFolder(patch: String) {
        
        var correctedPatch = patch.replacingOccurrences(of: "file:///", with: "/")
        correctedPatch = correctedPatch.replacingOccurrences(of: "%20", with: " ")
        
        do {
            try FileManager.default.createDirectory(atPath: correctedPatch, withIntermediateDirectories: true, attributes: nil)
        }
        catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    
    public func cleanFolder(patch: String) {
        
        let folderUrl = URL(string: patch)!
        
        do {
            let fileURLs = try FileManager
                .default
                .contentsOfDirectory(at: folderUrl,
                                     includingPropertiesForKeys: nil,
                                     options: [.skipsSubdirectoryDescendants])
            
            for fileURL in fileURLs {
                try FileManager.default.removeItem(at: fileURL)
            }
            
        } catch {
            print(error)
        }
    }
    
    
    
    public func cleanXmlFromFolder(patch: String) {
        
        let folderUrl = URL(string: patch)!
        
        do {
            let fileURLs = try FileManager
                .default
                .contentsOfDirectory(at: folderUrl,
                                     includingPropertiesForKeys: nil,
                                     options: [.skipsHiddenFiles,
                                               .skipsSubdirectoryDescendants])
            
            for fileURL in fileURLs {
                if fileURL.absoluteString.hasSuffix(".xml") {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    
    public func cleanFiletypeFromFolder(patch: String, filetype: String) {
        
        let folderUrl = URL(string: patch)!
        
        do {
            let fileURLs = try FileManager
                .default
                .contentsOfDirectory(at: folderUrl,
                                     includingPropertiesForKeys: nil,
                                     options: [.skipsSubdirectoryDescendants])
  
            for fileURL in fileURLs {
                if fileURL.absoluteString.hasSuffix("." + filetype) {
                    try FileManager.default.removeItem(at: fileURL)
                }
            }
            
        } catch {
            print(error)
        }
    }
    
    
    
    
    public func secureCopyItem(at source: String, to destination: String) -> Bool {
        
        let srcURL = URL(string: source)!
        let dstURL = URL(string: destination)!
        
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
        } catch (let error) {
            print("Cannot copy item at \(srcURL) to \(dstURL): \(error)")
            return false
        }
        return true
    }
    
    
    
}
