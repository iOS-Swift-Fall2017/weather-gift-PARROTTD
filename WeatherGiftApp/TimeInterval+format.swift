//
//  TimeInterval+format.swift
//  WeatherGiftApp
//
//  Created by Duncan Parrott on 11/5/17.
//  Copyright © 2017 Parrott. All rights reserved.
//

import Foundation

extension TimeInterval {
    func format(timeZone: String, dateFormatter: DateFormatter) -> String {
        let usableDate = Date(timeIntervalSince1970: self)
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        let dateString = dateFormatter.string(from: usableDate)
        return dateString
    }
}
