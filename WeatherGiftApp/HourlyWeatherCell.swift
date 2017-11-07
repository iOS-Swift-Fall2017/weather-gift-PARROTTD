//
//  HourlyWeatherCell.swift
//  WeatherGiftApp
//
//  Created by Duncan Parrott on 11/6/17.
//  Copyright © 2017 Parrott. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "ha"
    
    return dateFormatter
}()

class HourlyWeatherCell: UICollectionViewCell {
    
    
    @IBOutlet weak var hourlyTime: UILabel!
    @IBOutlet weak var hourlyTemp: UILabel!
    @IBOutlet weak var hourlyPrecipProb: UILabel!
    @IBOutlet weak var hourlyIcon: UIImageView!
    @IBOutlet weak var rainDropImage: UIImageView!
    
    func update(with hourlyForecast: WeatherDetail.HourlyForcast, timeZone: String) {
        hourlyTemp.text = String(format: "%2.f", hourlyForecast.hourlyTemperature) + "°"
        hourlyIcon.image = UIImage(named: hourlyForecast.hourlyIcon + "small-")
        let precipProb = hourlyForecast.hourlyPrecipProb * 100
        let isHidden = (precipProb < 30.0)
        hourlyPrecipProb.isHidden = isHidden
        rainDropImage.isHidden = isHidden
        hourlyPrecipProb.text = String(format: "%2.f", precipProb) + "%"
        let dateString = hourlyForecast.hourlyTime.format(timeZone: timeZone, dateFormatter: dateFormatter)
        hourlyTime.text = dateString
        
    }
    
}
