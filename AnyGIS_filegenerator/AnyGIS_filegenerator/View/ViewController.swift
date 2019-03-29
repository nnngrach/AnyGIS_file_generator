//
//  ViewController.swift
//  AnyGIS_filegenerator
//
//  Created by HR_book on 25/03/2019.
//  Copyright © 2019 Nnngrach. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    private let controller = Controller()
    
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
        controller.generateAll()
    }
    
    @IBAction func generateGuruBtn(_ sender: Any) {
        controller.generateMapsForGuru()
    }
    
    @IBAction func generateOruxBtn(_ sender: Any) {
        controller.generateMapsForOrux()
    }
    
    @IBAction func generateLocusBtn(_ sender: Any) {
        controller.generateMapsForLocus()
    }
    
    @IBAction func generteLocusInstallersBtn(_ sender: Any) {
        controller.generateInstallersForLocus()
    }
    
    @IBAction func generateOsmandBtn(_ sender: Any) {
        controller.generateMapsForOsmand()
    }
    
    @IBAction func generateWebPagesBtn(_ sender: Any) {
        controller.generateWebPages()
    }
    
}

