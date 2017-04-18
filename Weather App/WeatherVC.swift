//
//  WeatherVC.swift
//  Weather App
//
//  Created by BrillioImagine on 3/14/17.
//  Copyright © 2017 Brillio. All rights reserved.
//
//Key is 7fb5ed3be03809cd290a36ddd4718c27
import UIKit
import Alamofire
import CoreLocation
class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var currDateLbl: UILabel!
    @IBOutlet weak var curLocLbl: UILabel!
    @IBOutlet weak var curLocImg: UIImageView!
    @IBOutlet weak var curTempTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather = CurrentWeather()

    var locationManager = CLLocationManager()
    var forecasts = [Forecast] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.locationManager.requestAlwaysAuthorization()
        
        print(CURRENT_WEATHER_URL)
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell{
            
            let foreCast = forecasts[indexPath.row]
            cell.configureCell(forecast: foreCast)
            return cell
            
        }else{
            return WeatherCell()
        }
    }
    
    func downloadForecastData(completed : @escaping DownloadComplete)  {
        let forecastURL = (string: FORECAST_URL)
        Alamofire.request(forecastURL).responseJSON{ response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
               
                if let list = dict["list"] as? [Dictionary<String, AnyObject>]{
                    
                    for obj in list{
                        let forecast = Forecast(weatherDict : obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
        
        
    }
    
    func updateMainUI (){
       
        currentTempLbl.text = String(format: "%.2f°C", currentWeather.currTemp)
        currDateLbl.text = currentWeather.curDate
        curLocLbl.text = currentWeather.cityName
        
        curTempTypeLbl.text = currentWeather.weatherType
        curLocImg.image = UIImage(named: curTempTypeLbl.text!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

}

