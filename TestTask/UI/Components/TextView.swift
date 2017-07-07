//
//  TextView.swift
//  TestTask
//
//  Created by Vladislav Novoseltsev on 30.06.2017.
//  Copyright © 2017 Vladislav Novoseltsev. All rights reserved.
//

import UIKit

let UI_FLOAT_LABEL_VERTICAL_INSET_OFFSET  = 8.0

enum Animation {
    case SHOW
    case HIDE
}

class TextView: UITextView , UITextViewDelegate {

    var storedTextColor: UIColor = UIColor.blue
    var storedtext: NSString = ""
    
    var xOrigin: CGFloat = 0
    var horizontalPadding:CGFloat = 0.0
    
    private var placeholder: String = ""
    
    var Placeholder: String {
        get{
            return self.placeholder
        }
        set(value){
            self.placeholder = value
            self.label.text = self.placeholder
            if(self.text.characters.count == 0) {
                self.text = self.placeholder
                self.textColor = self.placeholderTextColor
            }
            
            self.label.sizeToFit()
            self.labelValidation.sizeToFit()
            /*_placeholder = placeholder;
            
            _floatLabel.text = _placeholder;
            if (![self.text length]) {
                self.text = _placeholder;
                self.textColor = _placeholderTextColor;
            }
            
            [_floatLabel sizeToFit];*/
        }
        
    }
    var placeholderTextColor: UIColor = UIColor.black
    var label: UILabel = UILabel()
    var labelValidation: UILabel = UILabel()
    var fontlabel: UIFont = UIFont()
    var labelPassiveColor: UIColor = UIColor()
    var labelActiveColor: UIColor = UIColor()
    var labelAnimationDuration: NSNumber = 0
    var pastingEnabled: NSNumber = 0
    var copyingEnabled: NSNumber = 0
    var cuttingEnabled: NSNumber = 0
    var selectEnabled: NSNumber = 0
    var selectAllEnabled: NSNumber = 0
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setup()-> Void {
        
        self.delegate = self
        
        self.setupTextView()
        
        self.setupLabel()
        
        self.setupMenuController()
        
        
        labelActiveColor = UIColor(red: 121.0/255.0, green: 121.0/255.0, blue: 121.0/255.0, alpha: 1.0)
        labelPassiveColor = UIColor(red: 121.0/255.0, green: 121.0/255.0, blue: 121.0/255.0, alpha: 1.0)
        textAlignment = NSTextAlignment.left
        
        font = UIFont.systemFont(ofSize: 16.0)
        label.font = UIFont.systemFont(ofSize: 13.0)
        translatesAutoresizingMaskIntoConstraints = false
        
    
    }
    
    
    func setupTextView()-> Void {
        
        self.textContainer.maximumNumberOfLines = 1
        horizontalPadding = 5.0
    
        self.contentInset  = UIEdgeInsetsMake(2*CGFloat(UI_FLOAT_LABEL_VERTICAL_INSET_OFFSET), -textContainer.lineFragmentPadding, -textContainer.lineFragmentPadding, -textContainer.lineFragmentPadding)
        self.textAlignment = NSTextAlignment.left
        storedTextColor = UIColor.black
        
        placeholderTextColor = UIColor(red: 121.0/255.0, green: 121.0/255.0, blue: 121.0/255.0, alpha: 1.0)
       
        
    }
    
    func setupLabel()-> Void {
        label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        label.alpha = 0.0
        label.center = CGPoint(x: 0  , y: 0.0)
        self.addSubview(label)
        
        labelPassiveColor = UIColor.lightGray
        labelActiveColor = UIColor.blue
        
        labelValidation = UILabel()
        labelValidation.text = "sdfsdf"
        labelValidation.textColor = UIColor.black
        labelValidation.textAlignment = NSTextAlignment.left
        labelValidation.font = UIFont.boldSystemFont(ofSize: 12.0)
        labelValidation.alpha = 0.0
        labelValidation.center = CGPoint(x: 8, y: 30.0)
        self.addSubview(labelValidation)
        
        
        
        labelPassiveColor = UIColor.lightGray
        labelActiveColor = UIColor.blue
        
        labelAnimationDuration = 0.25
    }
    
    
    func toggleActionLabel(animationType: Animation)-> Void {
        if(animationType == Animation.SHOW ) {
            placeholder = ""
        } else{
            placeholder = label.text!
        }
        
        updateTextAlignment()
        
        // updatetextAligment
        let easingOptions:UIViewAnimationOptions
        
        if(animationType == Animation.HIDE ) {
            easingOptions = UIViewAnimationOptions.curveEaseOut
        } else{
            easingOptions = UIViewAnimationOptions.curveEaseIn
        }
        
        
        UIView.animate(withDuration: TimeInterval(labelAnimationDuration), delay: 0.0, options: easingOptions, animations: {
            self.toggleFloatLabelProperties(animationType: animationType)
        }, completion: nil)
    }
    
    
    func toggleFloatLabelProperties(animationType: Animation) {
        
        var yOrigin: CGFloat = 0.0
        if( animationType == Animation.SHOW ) {
            label.alpha = 1.0
            yOrigin = -(CGFloat)(15)
        } else {
            label.alpha = 0.0
            self.text = self.placeholder;
            self.textColor = self.placeholderTextColor
            
        }
        
        label.frame = CGRect(x: xOrigin,y: yOrigin,width: label.frame.size.width,height: label.frame.size.height)
    }
    
    func updateTextAlignment()-> Void {
        let textAlignment: NSTextAlignment = self.textAlignment
        
        label.textAlignment = textAlignment
        
        switch textAlignment {
        case NSTextAlignment.right:
            self.xOrigin = self.frame.size.width - self.label.frame.size.width - horizontalPadding
         break
        case NSTextAlignment.center:
            self.xOrigin = self.frame.size.width / 2.0 - self.label.frame.size.width / 2.0
            break
        default:
            xOrigin = horizontalPadding
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateTextAlignment()
        
        if( !self.isFirstResponder && self.text.characters.count == 0) {
            self.toggleFloatLabelProperties(animationType: Animation.HIDE)
        }
    }
    
    func setupMenuController()-> Void {
        pastingEnabled = true;
        copyingEnabled = true;
        cuttingEnabled = true;
        selectEnabled = true;
        selectAllEnabled = true;
    }
    
    
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        label.textColor = self.labelActiveColor
        storedtext = self.text! as NSString
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        
        if(label.text?.characters.count != 0){
            label.textColor = labelPassiveColor
        }
        
        super.resignFirstResponder()
        
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if((self.text! as NSString).length != 0) {
            
            if((self.text! as NSString).isEqual(to: placeholder)) {
                self.text = nil;
                self.textColor = storedTextColor
            }
            
            
            if( label.alpha == 0) {
                self.toggleActionLabel(animationType: Animation.SHOW)
            }
        } else {
            
            if( label.alpha != 0) {
                self.toggleActionLabel(animationType: Animation.HIDE)
                
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if((self.text! as NSString).length == 0) {
            if( label.alpha != 0) {
                self.toggleActionLabel(animationType: Animation.HIDE)
                
            }
            
            
        } else {
            self.validation(text: self.text)
        }
    }
    
    
    func validation (text: String)->Void{
       
    }
    
     
    
    
   
    
}
