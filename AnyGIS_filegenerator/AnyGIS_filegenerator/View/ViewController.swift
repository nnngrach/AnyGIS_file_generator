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
    
    @IBAction func generateOsmandMetainfoBtn(_ sender: Any) {
        controller.generateMapsForOsmandMetainfo()
    }
    
    @IBAction func generateOsmandOsfBtn(_ sender: Any) {
        controller.generateMapsForOsmandOsf()
    }
    
    @IBAction func generateAlpineinfoBtn(_ sender: Any) {
        controller.generateMapsForAlpine()
    }
    
    @IBAction func generateDesktoptBtn(_ sender: Any) {
        controller.generateMapsForDesktop()
    }
    
    @IBAction func generateSasPlanetBtn(_ sender: Any) {
        controller.generateMapsForSasPlanet()
    }
    
    
    @IBAction func generateWebPagesBtn(_ sender: Any) {
        controller.generateWebPages()
    }
    
//    @IBAction func parseWestraGeoJson(_ sender: Any) {
//        controller.parseWestraGeoJson()
//    }
//    
//    @IBAction func parseOsmXmlToGeoJson(_ sender: Any) {
//        controller.parseOsmToGeoJson()
//    }
    
}

