//
//  PasswordTextView.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 30.06.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import UIKit

class PasswordTextView: TextView {
    
    var isValidation:Bool = false
    
    var emailTest:NSPredicate = NSPredicate()
    var password:String = ""
    
    /*init(text: String?) {
        super.init()
        let emailRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,}$"
        
        emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    }*/
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let emailRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,}$"
        
        emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    
    override func validation(text: String) -> Void {
        
        if( emailTest.evaluate(with: password)) {
            
            isValidation = true
        } else {
            isValidation = false
           
        }
        
    }
    

    override func textViewDidChange(_ textView: UITextView) {
        
        
        var localPassword:String
        localPassword = textView.text
        if(textView.text.characters.count == 0 ) {
            password = ""
            self.text = ""
            return 
        } else if(localPassword.endIndex < password.endIndex) {
            password = password.substring(to: password.index(before: password.endIndex))
        } else{
            let ch: String = localPassword.substring(from: password.endIndex)
            password.append(ch)
        }
        initSecureTextView(count: password.characters.count)
        validation(text: password)
    }
    
    
    func initSecureTextView(count: Int)-> Void {
        var pas: String = ""
        
        for _ in 0...(count - 1) {
            pas.append("*")
        }
        self.text = pas
    }
    
    
    

}
