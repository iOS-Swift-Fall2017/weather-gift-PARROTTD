//
//  DayWeatherCell.swift
//  WeatherGiftApp
//
//  Created by Duncan Parrott on 10/30/17.
//  Copyright © 2017 Parrott. All rights reserved.
//

import UIKit

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    
    return dateFormatter
}()

class DayWeatherCell: UITableViewCell {

    
    @IBOutlet weak var dayCellIcon: UIImageView!
    @IBOutlet weak var dayCellWeekDay: UILabel!
    @IBOutlet weak var dayCellMaxTemp: UILabel!
    @IBOutlet weak var dayCellMinView: UILabel!
    @IBOutlet weak var dayCellSummary: UITextView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func update(with dailyForecast: WeatherDetail.DailyForecast, timeZone: String) {
        dayCellIcon.image = UIImage(named: dailyForecast.dailyicon)
        dayCellSummary.text = dailyForecast.dailySummary
        dayCellMaxTemp.text = String(format: "%2.f", dailyForecast.dailyMaxTemp) + "°"
        dayCellMinView.text = String(format: "%2.f", dailyForecast.dailyMinTemp) + "°"
        
        

        let dateString = dailyForecast.dailyDate.format(timeZone: timeZone, dateFormatter: dateFormatter)
        dayCellWeekDay.text = dateString
    }
    
    
}
