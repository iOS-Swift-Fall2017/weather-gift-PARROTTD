//
//  DetailVC.swift
//  WeatherGiftApp
//
//  Created by Duncan Parrott on 10/16/17.
//  Copyright © 2017 Parrott. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var currentImage: UIImageView!
    
    var currentPage = 0
    var locationsArray = ["Location city", "sea island ga", " lake forest il"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationLabel.text = locationsArray[currentPage]
    }

    
}
