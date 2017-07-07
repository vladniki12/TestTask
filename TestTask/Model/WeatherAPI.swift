//
//  WeatherAPI.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 05.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import UIKit



class WeatherAPI: NSObject {
    
    static let APPID = "b5baac0b87e219bfad006ee836f6594a"
    static let baseURL = "http://api.openweathermap.org"
    
    static func getWeather()-> String {
        return baseURL + "/data/2.5/weather"
    }

}
