//
//  GlobalClass.swift
//  Hoovene
//
//  Created by Karthick on 12/06/17.
//  Copyright © 2017 Technoduce. All rights reserved.
//

import UIKit

class GlobalClass: NSObject {

    static let sharedInstance: GlobalClass = GlobalClass()
    static let language =  Locale.preferredLanguages[0].components(separatedBy: "-").first ?? Locale.preferredLanguages[0]
    var activityBackgroundView : UIView!
    var myActivityIndicator:UIActivityIndicatorView!
    var connected: Bool!
    var strLabel = UILabel()
    var msgFrame = UIView()
    let loading = InstagramActivityIndicator()
  
    // MARK: activity
  func activity(){
    
    let view = UIApplication.shared.keyWindow!
    
    DispatchQueue.main.async(execute: {
      //  set fullview bacground
      let screenSize: CGRect = UIScreen.main.bounds
      self.activityBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
      //Set background color
      
      self.activityBackgroundView.backgroundColor = UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.1)
      self.activityBackgroundView.tag = 103
      
      // set center gray color bacground view
      self.msgFrame = UIView(frame: CGRect(x: view.frame.midX - 90, y: view.frame.midY - 40 , width: 120, height: 120))
      self.msgFrame.center = self.activityBackgroundView.center
      self.msgFrame.layer.cornerRadius = 15
      self.msgFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
      
      //  set activity view controller in center gray view
      self.loading.frame = CGRect(x:(self.msgFrame.frame.width/2)-40 , y:(self.msgFrame.frame.height/2)-40, width: 80, height: 80)
      //loading.animationDuration = 0
      self.loading.rotationDuration = 3
      self.loading.numSegments = 15
      self.loading.strokeColor = UIColor.white
      self.loading.lineWidth = 3
      self.loading.startAnimating()
      self.msgFrame.addSubview(self.loading)
      self.activityBackgroundView.addSubview(self.msgFrame)
      view.addSubview(self.activityBackgroundView)
    })
  }
 
  
  
  // MARK: removeActivity
  func removeActivity(){
    DispatchQueue.main.async(execute: {
      self.activityBackgroundView.removeFromSuperview()
    })
  }
    
    // global alert view function
    // MARK: alertView
    func alertView(title: String, message: String, action: String, sender: UIViewController)
    {
        DispatchQueue.main.async(execute: {
                        // set alertController for above ios 8 OS
                        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.default, handler:nil))
                        sender.present(alert, animated: true, completion: nil)
        })
    }

    // MARK: hasConnectivity
    func hasConnectivity() -> Bool {
        do{
            let reachability = Reachability()
            if  (reachability?.isReachable)!{
                return true
            }else{
                return false
            }
        }
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat, view:UIView){
      
      let movementDistance:CGFloat = -moveValue
      let movementDuration: Double = 0.3
      var movement:CGFloat = 0
      if up{
        movement = movementDistance
      }else{
        movement = -movementDistance
      }
      UIView.beginAnimations("animateTextField", context: nil)
      UIView.setAnimationBeginsFromCurrentState(true)
      UIView.setAnimationDuration(movementDuration)
      view.frame = view.frame.offsetBy(dx: 0, dy: movement)
      UIView.commitAnimations()
    }
    
     // MARK:- attributed TextField
    func labelAttributedText(totalString: String, rangeofString: String) -> NSMutableAttributedString {
        let text = totalString
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: rangeofString)
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle,value: NSUnderlineStyle.styleSingle.rawValue, range: range1)
        underlineAttriString.addAttribute(NSAttributedStringKey.foregroundColor,value: UIColor.appDarkBlueColor, range: range1)
        return underlineAttriString;
    }
    
     // MARK:- setUpTextField
    func setUpTextField(textField: UITextField){
        textField.layer.cornerRadius = textField.frame.size.height/2
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.white
    }
    
    // MARK:- setUpTextField
    func setUpTextFields(textField: UITextField, placeHolder:String){
        textField.placeholder = placeHolder;
        textField.textColor = UIColor.appBlackColor
        textField.font = UIFont.regularFont16
        textField.backgroundColor = UIColor.clear
        textField.layer.cornerRadius = textField.frame.size.height/2
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.backgroundColor = UIColor.white
    }
    
    // MARK:- isEmpty
    func isEmpty(string: String? = String()) -> Bool
    {
        if string == nil || (string ?? "").isEmpty
        {
            return true
        }
        return false
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func getCustomerKey() -> String
    {
        return getUserInfo().value(forKeyPath: "user_key") as? String ?? ""
    }
    func getUserInfo() -> NSDictionary
    {
        if let getUserInfo = UserDefaults.standard.dictionary(forKey: "userinfo")
        {
            //print(getUserInfo)
            return getUserInfo as NSDictionary
        }
        return [:]
    }
    
    func getCurrencySymbol() -> String
    {
        return "AED"
    }
  
  // MARK:- change Label text Color
    func labelTextColor(totalString: String, rangeofString: String, color : UIColor) -> NSMutableAttributedString {
    
    let underlineAttriString = NSMutableAttributedString(string: totalString)
    let range1 = (totalString as NSString).range(of: rangeofString)
    underlineAttriString.addAttribute(NSAttributedStringKey.foregroundColor,value: color, range: range1)
    
    return underlineAttriString;
  }
  
  //MARK:- Set Dynamic Points
  func setDecimalPoints(value: String) -> String {
    //print(value)
    let pi: Double = Double(value)!
    let gettingValur = String(format:"%.2f",pi)
    
    return gettingValur
  }
}


