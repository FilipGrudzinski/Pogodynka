//
//  ViewController.swift
//  Pogodynka
//
//  Created by Filip on 01/10/2018.
//  Copyright © 2018 Filip. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?"
    let APP_ID = "41a9bbf2708bb5733d3665462ae49b04"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }

    //MARK: - Networking
    /***************************************************************/
    
    func getWeatherData(url: String, parameters: [String : String]) {
    
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            
            if response.result.isSuccess {
                
                print("Success!")
                
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            } else {
                print("Error \(response.result.error!)")
                self.cityLabel.text = "Connection Issues"
                
                
            }
            
            
        }
    }
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
    

    func updateWeatherData(json: JSON) {
        
        if let tempResult = json["main"]["temp"].double {
            
            weatherDataModel.temperature = Int(tempResult - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            
            updateUIWithWeatherData()
            
            
        } else {
            
            cityLabel.text = "Weather Unavailable"
            
        }
    }
    

    //MARK: - UI Updates
    /***************************************************************/
    
    func updateUIWithWeatherData() {
        
        self.temperatureLabel.text = String(weatherDataModel.temperature)
        self.cityLabel.text = weatherDataModel.city
        self.weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    

    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
     
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            print("Latitude \(location.coordinate.latitude), Longitude \(location.coordinate.longitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params: [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
            
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        cityLabel.text = "Location unavailable"
        
    }
    
    
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    
    
    //Write the PrepareForSegue Method here
    
    
}

