//
//  CALayer.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 07.07.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import UIKit

extension CALayer {
    var borderUIColor: UIColor {
        set {
            self.borderColor = newValue.cgColor
        }
        
        get {
            return UIColor(cgColor: self.borderColor!)
        }
    }
}
