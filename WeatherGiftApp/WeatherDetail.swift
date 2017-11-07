//
//  WeatherDetail.swift
//  WeatherGiftApp
//
//  Created by Duncan Parrott on 10/23/17.
//  Copyright © 2017 Parrott. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherDetail: WeatherLocation {
    
    struct HourlyForcast {
        var hourlyTime: Double
        var hourlyTemperature: Double
        var hourlyPrecipProb: Double
        var hourlyIcon: String
    }
    
    struct DailyForecast {
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailyDate: Double
        var dailySummary: String
        var dailyicon: String
    }
    
    
    
   
    var currentTemp = "--"
    var currentSummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    var dailyForecastArray = [DailyForecast]()
    var hourlyForecastArray = [HourlyForcast]()
    
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
                let days = min(7, dailyDataArray.count - 1)
                for day in 1...days {
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let dateValue = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let dailySummary = json["daily"]["data"][day]["summary"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailyDate: dateValue, dailySummary: dailySummary, dailyicon: icon)
                    self.dailyForecastArray.append(newDailyForecast)
                }
                
                let hourlyDataArray = json["hourly"]["data"]
                self.hourlyForecastArray = []
                let hours = min(24, hourlyDataArray.count - 1)
                for hour in 1...hours {
                    let hourlyTime = json ["hourly"]["data"][hour]["time"].doubleValue
                    let hourlyTemperature = json["hourly"]["data"][hour]["temperature"].doubleValue
                    let hourlyPrecipProb = json["hourly"]["data"][hour]["precipProbability"].doubleValue
                    let hourlyIcon = json["hourly"]["data"][hour]["icon"].stringValue
                    let newHourlyForecast = HourlyForcast(hourlyTime: hourlyTime, hourlyTemperature: hourlyTemperature, hourlyPrecipProb: hourlyPrecipProb, hourlyIcon: hourlyIcon)
                    self.hourlyForecastArray.append(newHourlyForecast)
                }
                
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
