//
//  ViewController.swift
//  Unified at Home
//
//  Created by Vincent Blokker on 06/04/16.
//  Copyright © 2016 Vincent Blokker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeFront: UILabel!
    @IBOutlet weak var tempFront: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityTempLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!

    @IBAction func getDataButtonClicked(sender: AnyObject) {getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=" + cityNameTextField.text! + "&lang=nl&APPID=9ed5eb6afb5c25a014355d0e5f92777a")}
    
    
    
    
    // START DEFAULTS ------->
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // RELOADS
        NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        //NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(getWeatherData), userInfo: nil, repeats: true)

        // Weather
        getWeatherData("http://api.openweathermap.org/data/2.5/weather?q=hoofddorp,nl&APPID=9ed5eb6afb5c25a014355d0e5f92777a")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //  <------- END DEFAULTS

    
    
    
    
    
    
    
    // START TIME FUNCTIONS ------->
    func updateTime(){
        let dateAsString = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.NoStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm:ss a"
        let date = dateFormatter.dateFromString(dateAsString)
        
        dateFormatter.dateFormat = "HH:mm:ss"
        timeFront.text = dateFormatter.stringFromDate(date!)
        
    }
    //  <------- END TIME FUNCTIONS
    
    
    // START WEATHER FUNCTIONS ------->
    
    func getWeatherData(urlString: String) {
        let url = NSURL(string: urlString)
        
        print("This: " + urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.setLabels(data!)
            })
        }
        task.resume()
    }
    
    func setLabels(weatherData: NSData) {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(weatherData, options:NSJSONReadingOptions.MutableContainers) as! NSDictionary
            print(json)
            
            if let name = json[("name")] as? String {
                cityNameLabel.text = name
            }
            
            if let main = json[("main")] as? NSDictionary {
                if let temp = main[("temp")] as? Double {
                    //convert kelvin to celsius
                    let mainTemp = String(format: "%.1f", (temp - 273.15))
                    cityTempLabel.text = mainTemp + "˚"
                }
            }
            
            if let weather = json[("weather")] as? NSDictionary {
                if let icon = weather[("icon")] as? String {
                    self.weatherIconImage.image = UIImage(named: "weather_sun")
                }
            }
            
            
        } catch let error as NSError {
            print(error)
        }
    }
    //  <------- END WEATHER FUNCTIONS

    
}