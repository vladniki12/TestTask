//
//  EmailTextView.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 30.06.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import UIKit

class EmailTextView: TextView {

    var emailTest:NSPredicate = NSPredicate()
    var isValidation:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}"
        
        emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    }

   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // fatalError("init(coder:) has not been implemented")
    }
    
 
    override func validation(text: String) -> Void {

        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}"
    
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if( emailTest.evaluate(with: text)) {
            
            isValidation = true
        } else {
            isValidation = false
            
        }
    
    }
    
}
