//
//  Weather.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 05.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Weather {
    let date: NSDate
    let temp: String
    

    init?(json: JSON) {
    
        guard case
            let timestamp = json["dt"].double,
            let temp = json["main"]["temp"].string
    
            else {
                return nil
        }
    
        self.date = NSDate(timeIntervalSince1970: timestamp!)
        self.temp = temp
    
    }
}
