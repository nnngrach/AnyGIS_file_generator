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
            try handler.test()
        } catch {
           print(error)
        }
        
    }
    
    @IBAction func generateGuruBtn(_ sender: Any) {
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

