//
//  Location.swift
//  Weather App
//
//  Created by BrillioImagine on 3/15/17.
//  Copyright © 2017 Brillio. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    static var sharedInstance = Location()
    
    init() {}
    
    var latitude : Double!
    var longitude : Double!
}
