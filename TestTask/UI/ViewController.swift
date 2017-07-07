//
//  ViewController.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 29.06.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import DeviceKit

class ViewController: UIViewController {

    
    @IBOutlet var tapGuesterRcognizer: UITapGestureRecognizer!
    @IBOutlet weak var emailTextView: EmailTextView!
    
    @IBOutlet weak var passwordTextView: PasswordTextView!
    
    @IBOutlet weak var remeberMeButton: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var viewComponents: UIView!
    
    var heightMainView:Float = 0.0
    
    var disposebag:DisposeBag = DisposeBag()
    
    private var weather: Observable<Weather>? = nil
    
    
    var searchText = Variable<String>("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remeberMeButton.clipsToBounds = true
        remeberMeButton.backgroundColor = UIColor.clear
        remeberMeButton.layer.borderColor = UIColor(red:235/255.0, green:235/255.0, blue:235/255.0, alpha: 1.0).cgColor
        
        
        
        button.rx.controlEvent(UIControlEvents.touchUpInside).asDriver().drive(onNext: {
            
            if ( !self.emailTextView.isValidation ) {
                self.createAlertDialog(title: "Ошибка", message: "Invalid Email")
            } else if( !self.passwordTextView.isValidation ){
                self.createAlertDialog(title: "Ошибка", message: "Invalid Password")
            } else {
                WeatherManager.instance.getW{
                    result in
                    self.createAlertDialog(title: "Success", message: "Температура:" + (result.floatValue - 273.15).description)
                }
            }
          
        }).disposed(by: disposebag)

        
        emailTextView.Placeholder = "Почта"
        passwordTextView.Placeholder = "Пароль"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1.0)]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as? [String : Any]
        
        self.automaticallyAdjustsScrollViewInsets = true
        
        tapGuesterRcognizer.rx.event.asDriver().drive(onNext: { [unowned self] _ in
            self.view.endEditing(true)
        }).addDisposableTo(disposebag)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                heightMainView = Float(self.view.frame.origin.y)
                
                print(UIScreen.main.nativeScale)
                
                
                let device = Device()
                
                if( device == .simulator(.iPhone5s) || device == .simulator(.iPhone5) || device == .simulator(.iPhone5c) || device == .simulator(.iPhoneSE) ) {
                    self.view.frame.origin.y -= keyboardSize.height/(2.0)
                } else if( device == .simulator(.iPhone6s) || device == .simulator(.iPhone6) || device == .simulator(.iPhone7) ) {
                    self.view.frame.origin.y -= keyboardSize.height/(4.0)
                } else if( device == .simulator(.iPhone6sPlus) || device == .simulator(.iPhone6Plus) || device == .simulator(.iPhone7Plus) ) {
                    self.view.frame.origin.y -= keyboardSize.height/2.0
                }
                
                if( device == .iPhone5s || device == (.iPhone5) || device == (.iPhone5c) || device == (.iPhoneSE) ) {
                    self.view.frame.origin.y -= keyboardSize.height/(2.0)
                } else if( device == (.iPhone6s) || device == (.iPhone6) || device == (.iPhone7) ) {
                    self.view.frame.origin.y -= keyboardSize.height/(4.0)
                } else if( device == (.iPhone6sPlus) || device == (.iPhone6Plus) || device == (.iPhone7Plus) ) {
                    self.view.frame.origin.y -= keyboardSize.height/2.0
                }
                
                
                
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y  = CGFloat(heightMainView)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
   
    @IBAction func pressedBack(_ sender: Any) {
      _ = navigationController?.popViewController(animated: true)
    }
    
    
    
    func createAlertDialog(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}

