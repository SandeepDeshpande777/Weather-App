//
//  WeatherForecast.swift
//  Weather App
//
//  Created by BrillioImagine on 3/15/17.
//  Copyright © 2017 Brillio. All rights reserved.
//

import UIKit
import Alamofire

class Forecast{
    var _weathertype : String!
    var _date : String!
    var _highTemp : String!
    var _lowTemp : String!
    
    var date : String{
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType : String {
        if _weathertype == nil {
            _weathertype = ""
        }
        return _weathertype
    }
    
    var highTemp : String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp : String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict : Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject>{
            
            if let min = temp["min"] as? Double{
                let minVal = min - 273.00
                _lowTemp = "\(minVal)"
            }
            
            if let max = temp["max"] as? Double{
                let maxVal = max - 273.00
                _highTemp = "\(maxVal)"
            }
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>]{
            if let main = weather[0]["main"] as? String{
                self._weathertype = main
            }
            
        }
        
        if let date = weatherDict["dt"] as? Double{
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
    
}

extension Date{
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
