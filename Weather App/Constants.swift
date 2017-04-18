//
//  Constants.swift
//  Weather App
//
//  Created by BrillioImagine on 3/14/17.
//  Copyright © 2017 Brillio. All rights reserved.
//

import Foundation

let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"


let LONGITUDE = "&lon="
let LATITUDE = "lat="
let APP_ID = "&appid=2109612b9e927f83efb184e8e20a32ab"
typealias DownloadComplete = () -> ()
let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)-36\(LONGITUDE)123\(APP_ID)"

let FORECAST_URL = "http://samples.openweathermap.org/data/2.5/forecast/daily?lat=-36&lon=123&cnt=10&appid=7fb5ed3be03809cd290a36ddd4718c27"
