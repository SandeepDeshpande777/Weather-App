//
//  CurrentWeather.swift
//  Weather App
//
//  Created by BrillioImagine on 3/14/17.
//  Copyright © 2017 Brillio. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    var _cityName : String!
    var _currTemp : Double!
    var _curDate : String!
    var _weather_type : String!
    
    var cityName : String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var currTemp : Double {
        if _currTemp == nil{
            _currTemp = 0.0
        }
        return _currTemp
    }
    
    var curDate : String{
        if _curDate == nil{
            _curDate = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let currDate = dateFormatter.string(from: Date())
        
        self._curDate = "Today, \(currDate)"
        return _curDate
    }
    
    var weatherType : String{
        if _weather_type == nil{
            _weather_type = ""
        }
        return _weather_type
    }
    
    func downloadWeatherDetails (completed : @escaping DownloadComplete){
        let currentWeatherUrl =  URL(string: CURRENT_WEATHER_URL)
        Alamofire.request(currentWeatherUrl!).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String{
                    self._cityName = name
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary <String, AnyObject>] {
                    if let main = weather[0] ["main"] as? String{
                        self._weather_type = main.capitalized
                        print(self._weather_type)
                    }
                }
                
                if let main = dict ["main"] as? Dictionary<String, AnyObject>{
                    if let currentTemperature = main["temp"] as? Double{
                        let kelvintoCelcius = currentTemperature - 273.00
                        
                        self._currTemp = kelvintoCelcius
                        print(self._currTemp)
                    }
                    
                }
            }
            completed()
        }
        
    }
    
}
