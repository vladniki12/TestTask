//
//  WeatherManager.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 05.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxAlamofire
import SwiftyJSON
import RxCocoa

class WeatherManager: NSObject {
    enum APIError: Error {
        case CannotParse
    }
    
    static var instance:WeatherManager = WeatherManager()
    
    
    func getW(compleate: @escaping (_ result: NSNumber)-> Void) -> Void {
        let params: [String: String] = [
            "q": "Barnaul,ru",
            "appid": WeatherAPI.APPID
        ]
        let url:String = WeatherAPI.getWeather() + "?q=Barnaul,ru&appid="+WeatherAPI.APPID
        Alamofire.request(url, method: .post, parameters:params, encoding: JSONEncoding.default, headers: nil).responseJSON{
            (response) in
            if let result = response.result.value {
                let json = result as! Dictionary<String, Any>
                print(json)
                
                compleate((json["main"] as! Dictionary<String, Any>)["temp"] as! NSNumber)
            }
            
        }
        
    }
}
