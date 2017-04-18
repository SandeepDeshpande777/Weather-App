//
//  WeatherCell.swift
//  Weather App
//
//  Created by BrillioImagine on 3/15/17.
//  Copyright © 2017 Brillio. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var weatherTypeLbl: UILabel!
    
    @IBOutlet weak var dayLbl: UILabel!
    
    @IBOutlet weak var highTempLbl: UILabel!
    
    @IBOutlet weak var lowTempLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(forecast : Forecast){
        lowTempLbl.text = String(format: "%.2f°C", forecast.lowTemp)
        highTempLbl.text = "\(forecast.highTemp)°"
        weatherTypeLbl.text = forecast.weatherType
        dayLbl.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
