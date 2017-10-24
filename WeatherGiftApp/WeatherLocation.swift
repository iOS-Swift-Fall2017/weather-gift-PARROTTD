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
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var currentSummary = ""
    
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
            case .failure(let error):
                print(error)
            }
            completed()
        }
    }
}
