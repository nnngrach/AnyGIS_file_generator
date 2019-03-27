//
//  ViewController.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 25/03/2019.
//  Copyright © 2019 H.Rach. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func generateAllBtn(_ sender: Any) {
        let handler = SqlitedbHandler()
        do {
            try handler.createFile(zoommin: "-3", zoommax: "16", patch: "url", projection: 0 )
        } catch {
           print(error)
        }
        
    }
    
    @IBAction func generateGuruBtn(_ sender: Any) {
        let handler = SqliteHandler()
        do {
            //try handler.getMapProcessingData()
            try handler.getMapClientFilesData()
        } catch {
            print(error)
        }
    }
    
    @IBAction func generateOruxBtn(_ sender: Any) {
    }
    
    @IBAction func generateLocusBtn(_ sender: Any) {
    }
    
    @IBAction func generteLocusInstallersBtn(_ sender: Any) {
    }
    
    @IBAction func generateOsmandBtn(_ sender: Any) {
    }
    

}

