//
//  WeatherLocation.swift
//  WeatherGiftApp
//
//  Created by Duncan Parrott on 10/23/17.
//  Copyright © 2017 Parrott. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    
    struct DailyForecast {
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailySummary: String
        var dailyicon: String
    }
    
    
    
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    var dailyForecastArray = [DailyForecast]()
    
    func getWeather(completed: @escaping () -> ()) {
        
        let weatherURL = urlBase + urlAPIKey + coordinates
        
        Alamofire.request(weatherURL).responseJSON {response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let temperature = json["currently"]["temperature"].double {
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp
                }else {print("could not return temeprature")}
                if let summary = json["daily"]["summary"].string {
                    self.currentSummary = summary
                }else {print("could not return summary")}
                if let icon = json["currently"]["icon"].string {
                    self.currentIcon = icon
                }else {print("could not return an icon")}
                if let timeZone = json["timezone"].string {
                    print("time for \(self.name) is \(timeZone)")
                    self.timeZone = timeZone
                }else {print("could not return an timeZone")}
                if let time = json["currently"]["time"].double {
                    print("time for \(self.name) is \(time)")
                    self.currentTime = time
                }else {print("could not return an time")}
                let dailyDataArray = json["daily"]["data"]
                self.dailyForecastArray = []
                for day in 1...dailyDataArray.count - 1 {
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailySummary: dailySummary, dailyicon: icon)
                    self.dailyForecastArray.append(newDailyForecast)
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
